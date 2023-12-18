package org.example.greensuper.models;

public class Category {
    private int categoryId;
    private String categoryType;
    private int image_id;

    public Category() {
    }

    public Category(int categoryId, String categoryType, int image_id) {
        this.categoryId = categoryId;
        this.categoryType = categoryType;
        this.image_id = image_id;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setCategoryType(String categoryType) {
        this.categoryType = categoryType;
    }

    public void setImage_id(int image_id) {
        this.image_id = image_id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getCategoryType() {
        return categoryType;
    }

    public int getImage_id() {
        return image_id;
    }
}
