package com.aurora.service.impl;

import com.aurora.constant.CommonConstant;
import com.aurora.entity.*;
import com.aurora.enums.*;
import com.aurora.mapper.*;
import com.aurora.model.dto.*;
import com.aurora.exception.BizException;
import com.aurora.service.*;
import com.aurora.strategy.context.UploadStrategyContext;
import com.aurora.util.BeanCopyUtil;
import com.aurora.util.UserUtil;
import com.aurora.model.vo.*;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;
import java.util.stream.Collectors;

import static com.aurora.constant.CommonConstant.FALSE;
import static com.aurora.constant.CommonConstant.TRUE;
import static com.aurora.constant.RedisConstant.USER_CODE_KEY;
import static com.aurora.util.CommonUtil.checkEmail;
import static com.aurora.util.PageUtil.getLimitCurrent;
import static com.aurora.util.PageUtil.getSize;


@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements UserInfoService {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private UserAuthMapper userAuthMapper;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private RedisService redisService;

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    private UploadStrategyContext uploadStrategyContext;

    @Autowired
    private AuroraInfoService auroraInfoService;

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private TalkService talkService;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private ArticleTagMapper articleTagMapper;


    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateUserInfo(UserInfoVO userInfoVO) {
        UserInfo userInfo = UserInfo.builder()
                .id(UserUtil.getUserDetailsDTO().getUserInfoId())
                .nickname(userInfoVO.getNickname())
                .intro(userInfoVO.getIntro())
                .userAge(userInfoVO.getUserAge())
                .userGender(userInfoVO.getUserGender())
                .website(userInfoVO.getWebsite())
                .build();
        userInfoMapper.updateById(userInfo);
    }

    @Override
    public String updateUserAvatar(MultipartFile file) {
        String avatar = uploadStrategyContext.executeUploadStrategy(file, FilePathEnum.AVATAR.getPath());
        UserInfo userInfo = UserInfo.builder()
                .id(UserUtil.getUserDetailsDTO().getUserInfoId())
                .avatar(avatar)
                .build();
        userInfoMapper.updateById(userInfo);
        return avatar;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void saveUserEmail(EmailVO emailVO) {
        if (Objects.isNull(redisService.get(USER_CODE_KEY + emailVO.getEmail()))) {
            throw new BizException("验证码错误");
        }
        if (!emailVO.getCode().equals(redisService.get(USER_CODE_KEY + emailVO.getEmail()).toString())) {
            throw new BizException("验证码错误！");
        }
        UserInfo userInfo = UserInfo.builder()
                .id(UserUtil.getUserDetailsDTO().getUserInfoId())
                .email(emailVO.getEmail())
                .build();
        userInfoMapper.updateById(userInfo);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateUserSubscribe(SubscribeVO subscribeVO) {
        UserInfo temp = userInfoMapper.selectOne(new LambdaQueryWrapper<UserInfo>().eq(UserInfo::getId, subscribeVO.getUserId()));
        if (StringUtils.isEmpty(temp.getEmail())) {
            throw new BizException("邮箱未绑定！");
        }
        UserInfo userInfo = UserInfo.builder()
                .id(subscribeVO.getUserId())
                .isSubscribe(subscribeVO.getIsSubscribe())
                .build();
        userInfoMapper.updateById(userInfo);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateUserRole(UserRoleVO userRoleVO) {
        UserInfo userInfo = UserInfo.builder()
                .id(userRoleVO.getUserInfoId())
                .userAge(userRoleVO.getUserAge())
                .userGender(userRoleVO.getUserGender())
                .nickname(userRoleVO.getNickname())
                .build();
        userInfoMapper.updateById(userInfo);
        userRoleService.remove(new LambdaQueryWrapper<UserRole>()
                .eq(UserRole::getUserId, userRoleVO.getUserInfoId()));
        List<UserRole> userRoleList = userRoleVO.getRoleIds().stream()
                .map(roleId -> UserRole.builder()
                        .roleId(roleId)
                        .userId(userRoleVO.getUserInfoId())
                        .build())
                .collect(Collectors.toList());
        userRoleService.saveBatch(userRoleList);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateUserDisable(UserDisableVO userDisableVO) {
        removeOnlineUser(userDisableVO.getId());
        UserInfo userInfo = UserInfo.builder()
                .id(userDisableVO.getId())
                .isDisable(userDisableVO.getIsDisable())
                .build();
        userInfoMapper.updateById(userInfo);
    }

    @Override
    public PageResultDTO<UserOnlineDTO> listOnlineUsers(ConditionVO conditionVO) {
        Map<String, Object> userMaps = redisService.hGetAll("login_user");
        Collection<Object> values = userMaps.values();
        ArrayList<UserDetailsDTO> userDetailsDTOs = new ArrayList<>();
        for (Object value : values) {
            userDetailsDTOs.add((UserDetailsDTO) value);
        }
        List<UserOnlineDTO> userOnlineDTOs = BeanCopyUtil.copyList(userDetailsDTOs, UserOnlineDTO.class);
        List<UserOnlineDTO> onlineUsers = userOnlineDTOs.stream()
                .filter(item -> StringUtils.isBlank(conditionVO.getKeywords()) || item.getNickname().contains(conditionVO.getKeywords()))
                .sorted(Comparator.comparing(UserOnlineDTO::getLastLoginTime).reversed())
                .collect(Collectors.toList());
        int fromIndex = getLimitCurrent().intValue();
        int size = getSize().intValue();
        int toIndex = onlineUsers.size() - fromIndex > size ? fromIndex + size : onlineUsers.size();
        List<UserOnlineDTO> userOnlineList = onlineUsers.subList(fromIndex, toIndex);
        return new PageResultDTO<>(userOnlineList, onlineUsers.size());
    }

    @Override
    public void removeOnlineUser(Integer userInfoId) {
        Integer userId = userAuthMapper.selectOne(new LambdaQueryWrapper<UserAuth>().eq(UserAuth::getUserInfoId, userInfoId)).getId();
        tokenService.delLoginUser(userId);
    }

    @Override
    public UserInfoDTO getUserInfoById(Integer id) {
        UserInfo userInfo = userInfoMapper.selectById(id);
        return BeanCopyUtil.copyObject(userInfo, UserInfoDTO.class);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteUserInfo(Integer id) {
        // 1. 删除用户info
        removeById(id);
        // 2. 删除用户Auth
        userAuthMapper.delete(new LambdaQueryWrapper<UserAuth>().eq(UserAuth::getUserInfoId, id));
        // 3. 删除用户和角色关联信息
        userRoleService.remove(new LambdaQueryWrapper<UserRole>().eq(UserRole::getUserId, id));
    }

    @Override
    public List<UserAgeDTO> selectUserAgeData() {
        Integer oneCount = userInfoMapper.selectCount(new LambdaQueryWrapper<UserInfo>().isNotNull(UserInfo::getUserAge).le(UserInfo::getUserAge, 10));
        Integer twoCount = userInfoMapper.selectCount(new LambdaQueryWrapper<UserInfo>().isNotNull(UserInfo::getUserAge)
                .le(UserInfo::getUserAge, 20).gt(UserInfo::getUserAge, 10));
        Integer threeCount = userInfoMapper.selectCount(new LambdaQueryWrapper<UserInfo>().isNotNull(UserInfo::getUserAge)
                .le(UserInfo::getUserAge, 30).gt(UserInfo::getUserAge, 20));
        Integer fourCount = userInfoMapper.selectCount(new LambdaQueryWrapper<UserInfo>().isNotNull(UserInfo::getUserAge)
                .le(UserInfo::getUserAge, 40).gt(UserInfo::getUserAge, 30));
        Integer fiveCount = userInfoMapper.selectCount(new LambdaQueryWrapper<UserInfo>().isNotNull(UserInfo::getUserAge).gt(UserInfo::getUserAge, 40));
        List<UserAgeDTO> list = new ArrayList<>(5);
        list.add(new UserAgeDTO("10岁以下", oneCount));
        list.add(new UserAgeDTO("11-20岁", twoCount));
        list.add(new UserAgeDTO("21-30岁", threeCount));
        list.add(new UserAgeDTO("31-40岁", fourCount));
        list.add(new UserAgeDTO("40岁以上", fiveCount));
        return list;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveUserRole(AddUserVO addUserVO) {
        if (!checkEmail(addUserVO.getUsername())) {
            throw new BizException("邮箱格式不对!");
        }
        if (checkUser(addUserVO)) {
            throw new BizException("邮箱已被注册！");
        }
        UserInfo userInfo = UserInfo.builder()
                .email(addUserVO.getUsername())
                .userAge(addUserVO.getUserAge())
                .userGender(addUserVO.getUserGender())
                .nickname(CommonConstant.DEFAULT_NICKNAME + IdWorker.getId())
                .avatar(auroraInfoService.getWebsiteConfig().getUserAvatar())
                .build();
        userInfoMapper.insert(userInfo);
        UserRole userRole = UserRole.builder()
                .userId(userInfo.getId())
                .roleId(RoleEnum.USER.getRoleId())
                .build();
        userRoleMapper.insert(userRole);
        UserAuth userAuth = UserAuth.builder()
                .userInfoId(userInfo.getId())
                .username(addUserVO.getUsername())
                .password(BCrypt.hashpw(addUserVO.getPassword(), BCrypt.gensalt()))
                .loginType(LoginTypeEnum.EMAIL.getType())
                .build();
        userAuthMapper.insert(userAuth);
    }

    @Override
    public UserShowVO getUserShowById(Integer userInfoId) {
        UserShowVO userShowVO = new UserShowVO();
        // 查询用户审核通过公开可见的文章
        Integer articlesCount = articleService.lambdaQuery()
                .eq(Article::getUserId, userInfoId)
                .eq(Article::getReview, ArticleReviewEnum.OK_REVIEW.getReview())
                .ne(Article::getStatus, ArticleStatusEnum.DRAFT.getStatus())
                .count();
        // 查询用户的说说数量
        Integer talksCount = talkService.lambdaQuery().eq(Talk::getUserId, userInfoId).count();
        // 获得用户的留言数量
        LambdaQueryWrapper<Comment> queryWrapper  = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getUserId, userInfoId).eq(Comment::getIsReview,1);
        Integer messageCount = commentMapper.selectCount(queryWrapper);
        UserInfo userInfo = userInfoMapper.selectById(userInfoId);

        userShowVO.setMessageCount(messageCount);
        userShowVO.setUserIntro(userInfo.getIntro());
        userShowVO.setArticlesCount(articlesCount);
        userShowVO.setTalksCount(talksCount);
        userShowVO.setUserId(userInfoId);
        userShowVO.setAvatar(userInfo.getAvatar());
        userShowVO.setNickName(userInfo.getNickname());
        return userShowVO;
    }

    @Override
    public UserForegroundDTO getUserForegroundInfo(Integer userId) {
        UserForegroundDTO userForegroundDTO = new UserForegroundDTO();
        Integer messageCount = commentMapper.selectCount(new LambdaQueryWrapper<Comment>().eq(Comment::getIsDelete, FALSE)
                .eq(Comment::getType, 2).eq(Comment::getUserId, userId));
        userForegroundDTO.setMessageCount(messageCount);
        List<Article> articleList = articleMapper.selectList(new LambdaQueryWrapper<Article>().eq(Article::getIsDelete, FALSE).eq(Article::getUserId, userId));
        if (articleList.isEmpty()) {
            userForegroundDTO.setArticleCount(0);
            userForegroundDTO.setTopArticleCount(0);
            userForegroundDTO.setFeaturedArticleCount(0);
            userForegroundDTO.setPublishedArticleCount(0);
            userForegroundDTO.setPrivacyArticleCount(0);
            userForegroundDTO.setDraftCount(0);
            userForegroundDTO.setArticleStatisticsDTOs(new ArrayList<>());
            userForegroundDTO.setCategoryDTOs(new ArrayList<>());
            userForegroundDTO.setTagDTOs(new ArrayList<>());
        } else {
            // 获取所有文章
            long articleCount = articleList.stream().filter(article -> !article.getStatus().equals(3)).count();
            userForegroundDTO.setArticleCount((int) articleCount);
            // 获取置顶文章数量
            long topArticleCount = articleList.stream().filter(article -> !article.getStatus().equals(3))
                    .filter(article -> article.getIsTop().equals(TRUE)).count();
            userForegroundDTO.setTopArticleCount((int) topArticleCount);
            // 获取推荐文章的数量
            long featuredArticleCount = articleList.stream().filter(article -> !article.getStatus().equals(3))
                    .filter(article -> article.getIsFeatured().equals(TRUE)).count();
            userForegroundDTO.setFeaturedArticleCount((int) featuredArticleCount);
            // 获取公开的文章数量
            long publishArticleCount = articleList.stream().filter(article -> article.getStatus().equals(1)).count();
            userForegroundDTO.setPublishedArticleCount((int) publishArticleCount);
            // 获取私密文章数量
            long privacyArticleCount = articleList.stream().filter(article -> article.getStatus().equals(2)).count();
            userForegroundDTO.setPrivacyArticleCount((int) privacyArticleCount);
            // 获取草稿文章数量
            long draftCount = articleList.stream().filter(article -> article.getStatus().equals(3)).count();
            userForegroundDTO.setDraftCount((int) draftCount);
            // 获取用户贡献度
            List<ArticleStatisticsDTO> articleStatisticsDTOs = articleMapper.listUserArticleStatistics(userId);
            userForegroundDTO.setArticleStatisticsDTOs(articleStatisticsDTOs);
            // 获取文章的分类列表
            List<CategoryDTO> categoryDTOs = categoryMapper.listUserCategories(userId);
            userForegroundDTO.setCategoryDTOs(categoryDTOs);
            // 获取文章Top10的标签列表
            List<TagDTO> tagDTOs = BeanCopyUtil.copyList(tagMapper.listUserTopTenTags(userId), TagDTO.class);
            userForegroundDTO.setTagDTOs(tagDTOs);
        }
        return userForegroundDTO;
    }

    private Boolean checkUser(AddUserVO addUserVO) {
        UserAuth userAuth = userAuthMapper.selectOne(new LambdaQueryWrapper<UserAuth>()
                .select(UserAuth::getUsername)
                .eq(UserAuth::getUsername, addUserVO.getUsername()));
        return Objects.nonNull(userAuth);
    }
}
