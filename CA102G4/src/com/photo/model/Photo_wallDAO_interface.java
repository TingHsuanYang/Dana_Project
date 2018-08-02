package com.photo.model;

import java.util.List;

public interface Photo_wallDAO_interface {
	public void insert(Photo_wallVO photo_wallVO);
	public void update(Photo_wallVO photo_wallVO);
	public void delete(String photo_No);
	public Photo_wallVO findByPrimaryKey(String photo_No);
	public List<Photo_wallVO> getAll() ;

}
