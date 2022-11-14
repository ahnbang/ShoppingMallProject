package com.terzobang.product.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.terzobang.product.model.Image;
import com.terzobang.product.model.Item;

@Repository
public interface ProductDAO {
	
	public List<Item> selectAllProductList();
	public List<Image> selectImageListByItemId(int itemId);
	
	

}
