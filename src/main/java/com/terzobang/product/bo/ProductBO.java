package com.terzobang.product.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.terzobang.product.dao.ProductDAO;
import com.terzobang.product.model.Image;
import com.terzobang.product.model.Item;
import com.terzobang.product.model.Product;

@Service
@Transactional
public class ProductBO {
	
	@Autowired
	private ProductDAO productDAO;
	
	@Transactional
	public List<Product> getAllProduct(){
		List<Product> allProducts = new ArrayList<>();
		List<Item> itemList = productDAO.selectAllProductList();
		for(Item item : itemList) {
			List<Image> imageList = productDAO.selectImageListByItemId(item.getId());
			Product product = new Product();
			product.setItem(item);
			product.setImages(imageList);
			allProducts.add(product);
		}
		return allProducts; 
	}
	
	public Product getProductByItemId(int itemId) {
		Product product = new Product();
		product.setItem(productDAO.selectItemByItemId(itemId));
		product.setImages(productDAO.selectImageListByItemId(itemId));
		return product;
	}
	
	
	
	
	

}
