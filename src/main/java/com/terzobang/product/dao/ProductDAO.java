package com.terzobang.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.terzobang.product.model.Image;
import com.terzobang.product.model.Item;

@Repository
public interface ProductDAO {
	
	public List<Item> selectAllProductList();
	public Item selectItemByItemId(int itemId);
	public List<Image> selectImageListByItemId(int itemId);
	
	public void removeStock(@Param("itemId") int itemId, @Param("orderCount") int orderCount);
	
	
	

}
