package org.example.greensuper.models;

public class Category {
    private int categoryId;
    private String categoryType;
    private String imageName;

    public Category() {
    }

    public Category(int categoryId, String categoryType, String imageName) {
        this.categoryId = categoryId;
        this.categoryType = categoryType;
        this.imageName = imageName;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setCategoryType(String categoryType) {
        this.categoryType = categoryType;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getCategoryType() {
        return categoryType;
    }

    public String getImageName() {
        return imageName;
    }
}
