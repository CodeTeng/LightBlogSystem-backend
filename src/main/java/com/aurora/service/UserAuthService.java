package com.aurora.service;

import com.aurora.model.dto.*;
import com.aurora.model.vo.*;

import java.util.List;
import java.util.Map;

public interface UserAuthService {

    void sendCode(String username);

    List<UserAreaDTO> listUserAreas(ConditionVO conditionVO);

    void register(UserVO userVO);

    void updatePassword(UserVO userVO);

    void updateAdminPassword(PasswordVO passwordVO);

    PageResultDTO<UserAdminDTO> listUsers(ConditionVO condition);

    UserLogoutStatusDTO logout();

    UserInfoDTO qqLogin(QQLoginVO qqLoginVO);

    /**
     * 根据用户最后一次登录时间统计用户人数
     */
    List<UserActiveDTO>selectUserActiveData();

    /**
     * 统计最近三天用户的访问次数
     */
    List<UserActiveDTO> selectUserThreeActiveData();
}
