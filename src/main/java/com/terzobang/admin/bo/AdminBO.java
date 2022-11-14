package com.terzobang.admin.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.terzobang.admin.dao.AdminDAO;
import com.terzobang.common.FileManagerService;
import com.terzobang.common.response.Response;
import com.terzobang.common.response.ResponseUtil;
import com.terzobang.product.model.Item;
import com.terzobang.product.model.ItemCategory;
import com.terzobang.product.model.ItemSex;
@Transactional
@Service
public class AdminBO {
	
	@Autowired
	private AdminDAO adminDAO;
	
	@Autowired
	private FileManagerService fileManager;
	
	@Transactional
	public Response addProduct(String name, String content, ItemCategory category, ItemSex sex, String size, int price, int stock, List<MultipartFile> images) {
		
		Item item = new Item();
		item.setName(name);
		item.setContent(content);
		item.setCategory(category);
		item.setSex(sex);
		item.setSize(size);
		item.setPrice(price);
		item.setStock(stock);
		
		int itemRow = adminDAO.insertItem(item);
		if (itemRow < 0) {
			return ResponseUtil.FAIL("item insert error", item);
		}

		int itemId = item.getId();
		List<String> imagePathList = fileManager.saveFile(images, itemId);
		int imageRow = adminDAO.insertImage(imagePathList, itemId);
		if (imageRow < 0) {
			return ResponseUtil.FAIL("image insert error", imagePathList);
		}
		return ResponseUtil.SUCCESS("상품 추가가 완료되었습니다.", null);
	}

}
