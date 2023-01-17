package com.project.user.dao;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.user.model.User;

@Repository
public interface UserDAO {

	//회원가입 필수정보 insert
	public int insertUser(User user);
	
	//회원가입시 id 중복 event
	public int existingLoginId(String loginid);
	
	//로그인시 아이디 및 비밀번호 일치여부 확인 event
	public User selectUserByLoginIdAndPassword(User user);
	
	//회원가입 선택정보 insert
	public int updateUser(User user);
	
	public User selectUserByLoginId(@Param("loginid")String loginid);

	public int existingUserAddition(@Param("loginid")String loginid);
	
	
	//비밀번호 찾기 - 아이디 및 이메일 일치 여부 event
	public User selectUserCheckByUserIdUserEmail(User user);
	
	//비밀번호 찾기 - 임시비밀번호 update event
	public void updateUserPassword(User user);
	
	public User findId(@Param("phonenumber")String phonenumber, @Param("email")String email);

}
