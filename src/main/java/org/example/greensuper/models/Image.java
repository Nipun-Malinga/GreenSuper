package org.example.greensuper.models;

public class Image {
    private int imageID;
    private String imageName;

    public Image() {
    }

    public Image(int imageID, String imageName) {
        this.imageID = imageID;
        this.imageName = imageName;
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public int getImageID() {
        return imageID;
    }

    public String getImageName() {
        return imageName;
    }
}
