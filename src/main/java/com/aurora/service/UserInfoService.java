package com.aurora.service;

import com.aurora.model.dto.*;
import com.aurora.entity.UserInfo;
import com.aurora.model.vo.*;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface UserInfoService extends IService<UserInfo> {

    void updateUserInfo(UserInfoVO userInfoVO);

    String updateUserAvatar(MultipartFile file);

    void saveUserEmail(EmailVO emailVO);

    void updateUserSubscribe(SubscribeVO subscribeVO);

    void updateUserRole(UserRoleVO userRoleVO);

    void updateUserDisable(UserDisableVO userDisableVO);

    PageResultDTO<UserOnlineDTO> listOnlineUsers(ConditionVO conditionVO);

    void removeOnlineUser(Integer userInfoId);

    UserInfoDTO getUserInfoById(Integer id);

    void deleteUserInfo(Integer id);

    /**
     * 统计用户年龄分布
     */
    List<UserAgeDTO> selectUserAgeData();

    /**
     * 添加用户角色
     *
     * @param addUserVO 添加用户请求体
     */
    void saveUserRole(AddUserVO addUserVO);

    /**
     * 获取用户展示框的信息
     * @param userInfoId
     * @return
     */
    UserShowVO getUserShowById(Integer userInfoId);

    /**
     * 获取个人用户前台信息
     */
    UserForegroundDTO getUserForegroundInfo(Integer userId);
}
