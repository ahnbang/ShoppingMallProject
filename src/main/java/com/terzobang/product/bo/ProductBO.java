package com.terzobang.product.bo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.terzobang.common.FileManagerService;
import com.terzobang.common.response.Response;
import com.terzobang.common.response.ResponseUtil;
import com.terzobang.product.dao.ProductDAO;
import com.terzobang.product.model.Image;
import com.terzobang.product.model.Item;
import com.terzobang.product.model.ItemCategory;
import com.terzobang.product.model.ItemSex;
import com.terzobang.product.model.Product;

@Service
@Transactional
public class ProductBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private final ProductDAO productDAO;
	private final FileManagerService fileManager;
	
	@Autowired
	public ProductBO(ProductDAO productDAO, FileManagerService fileManager){
		this.productDAO = productDAO;
		this.fileManager = fileManager;
	}
	
	@Transactional
	public Response createProduct(String name, String content, ItemCategory category, ItemSex sex, String size, int price, int stock, List<MultipartFile> images) {
		
		Item item = new Item();
		item.setName(name);
		item.setContent(content);
		item.setCategory(category);
		item.setSex(sex);
		item.setSize(size);
		item.setPrice(price);
		item.setStock(stock);
		int itemRow = productDAO.insertItem(item);
		if (itemRow < 0) {
			return ResponseUtil.FAIL("상품 추가에 실패 했습니다", item);
		}
		int itemId = item.getId();
		List<String> imagePathList = fileManager.saveFile(images, itemId);
		int imageRow = productDAO.insertImage(imagePathList, itemId);
		if (imageRow < 0) {
			return ResponseUtil.FAIL("image insert error", imagePathList);
		}
		
		return ResponseUtil.SUCCESS("상품 추가가 완료되었습니다.", null);
	}
	
	@Transactional(readOnly = true)
	public List<Product> getAllProduct(){
		List<Product> allProducts = new ArrayList<>();
		List<Item> itemList = productDAO.selectAllItemList();
		for(Item item : itemList) {
			List<Image> imageList = productDAO.selectImageListByItemId(item.getId());
			Product product = new Product();
			product.setItem(item);
			product.setImages(imageList);
			allProducts.add(product);
		}
		return allProducts; 
	}
	
	@Transactional(readOnly = true)
	public Product getProductByItemId(int itemId) {
		Product product = new Product();
		product.setItem(productDAO.selectItemByItemId(itemId));
		product.setImages(productDAO.selectImageListByItemId(itemId));
		return product;
	}
	
	@Transactional(readOnly = true)
	public List<Product> getProductByCategory(String category){
			
		List<Product> allProductsByCategory = new ArrayList<>();
		List<Item> itemList = productDAO.selectItemListByCateogry(category);
		for(Item item : itemList) {
			List<Image> imageList = productDAO.selectImageListByItemId(item.getId());
			Product product = new Product();
			product.setItem(item);
			product.setImages(imageList);
			allProductsByCategory.add(product);
		}
		return allProductsByCategory; 
	}
	
	@Transactional
	public Response deleteProductByitemId(int itemId) {
			
			
			Item item = productDAO.selectItemByItemId(itemId);
			if (item == null) {
				logger.error("[ProductBo][deleteProductByitemId] 삭제할 Item이 없습니다. itemId:{}", itemId);
				return ResponseUtil.FAIL("삭제할 상품이 존재하지 않습니다.", itemId);
			}
			int deleteItemRow = productDAO.deleteItemByitemId(itemId);
			
	
			List<Image> imageList = productDAO.selectImageListByItemId(itemId);
			if(imageList == null) {
				logger.error("[ProductBo][deleteProductByitemId] 삭제할 Image가 없습니다. itemId:{}", itemId);
				return ResponseUtil.FAIL("삭제할 상품의 이미지가 존재하지 않습니다.", itemId);
			}
				
			int deleteImageRow = productDAO.deleteImageByitemId(itemId);
			
			List<String> imagePathList = new ArrayList<>();
			for (Image image : imageList) {
				String path = image.getSaveName();
				imagePathList.add(path);
				}
			
			try {
				fileManager.deleteFile(imagePathList);
			} catch (IOException e) {
				logger.error("[ProductBo][deleteProductByitemId] 서버 이미지 삭제 실패");
				return ResponseUtil.FAIL("서버 이미지 삭제에 실패했습니다.", itemId);
			}
			return ResponseUtil.SUCCESS("해당 상품을 삭제했습니다.", itemId);
			}
	
	@Transactional
	public Response updateItemByItemId(int itemId, String name, String content, ItemCategory category, String size, int price, int stock, ItemSex sex) {
		
		Item item = productDAO.selectItemByItemId(itemId);
		if (item == null) {
			return ResponseUtil.ERROR("데이터를 변경할 상품이 존재하지 않습니다.", itemId);
		}
		
		item.setName(name);
		item.setContent(content);
		item.setCategory(category);
		item.setSize(size);
		item.setPrice(price);
		item.setStock(stock);
		item.setSex(sex);
		
		productDAO.updateItem(item);
		
		return ResponseUtil.SUCCESS("상품의 데이터를 변경했습니다.", item);
		
		
		
	}
	
	
	//Read Part
	@Transactional(readOnly = true)
	public Item getItemByItemId(int itemId) {
		return productDAO.selectItemByItemId(itemId);
	}
	
	//Update Part
	@Transactional
	public void updateStock(int itemId, int restStock){
		
		productDAO.updateStock(itemId, restStock);
		
	}
	
}

	
	
	

	

