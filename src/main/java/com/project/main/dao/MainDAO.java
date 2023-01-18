package com.project.main.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MainDAO {

	public int insertWait(@Param("user_id")int user_id,@Param("localid") String localid,@Param("user_gender") String user_gender,@Param("preference") String preference);

}
