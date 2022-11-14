package com.terzobang.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.terzobang.product.model.Item;

@Repository
public interface AdminDAO {
	
	public int insertItem(Item item);
	
	public int insertImage(@Param("imagePathList") List<String> imagePathList, @Param("itemId") int itemId);
}
