package com.terzobang.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.terzobang.product.model.Image;
import com.terzobang.product.model.Item;
import com.terzobang.product.model.ItemCategory;

@Repository
public interface ProductDAO {
	
	//Select
	public List<Item> selectAllItemList();
	public Item selectItemByItemId(int itemId);
	public List<Image> selectImageListByItemId(int itemId);
	public List<Item> selectItemListByCateogry(String category);
	
	//Insert
	public int insertItem(Item item);
	public int insertImage(@Param("imagePathList") List<String> imagePathList, @Param("itemId") int itemId);
	
	//Delete
	public int deleteItemByitemId(int itemId);
	public int deleteImageByitemId(int itemId);
	
	//Update
	public void updateStock(@Param("itemId") int itemId, @Param("restStock") int restStock);
	public void updateItem(Item item);
}