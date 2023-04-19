package com.example.attestacionspring.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Product {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "title", nullable = false, columnDefinition = "text", unique = true)
    @NotEmpty(message="Наименование не может быть пустым!")
    private  String title;

    @Column (name = "description", nullable = false)
    @NotEmpty(message = "Описание товара не может быть пустым!")
    private String description;

    @Column (name = "price", nullable = false)
    @Min(value = 1, message = "Цена не может быть меньше 1")
    private float price;

    @Column(name = "warehouse", nullable = false)
    @NotEmpty(message = "Укажите склад!!!")
    private String warehouse;


    @Column(name = "seller", nullable = false)
    @NotEmpty(message = "Заполните поле \"Продавец\"")
    private String seller;

    @ManyToOne(optional = false)
    private CategoryProduct categoryProduct;

    private LocalDateTime dateTime;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "product")
    private List<Image> imageList = new ArrayList<>();

    //Данный метод позволяет добавить фотографию в лист текущего продукта
    public void addImageToProduct(Image image){
        image.setProduct(this);
        imageList.add(image);
    }

    //Данный метод будет заполнять поле даты и времени при создании экземпляра класса
    @PrePersist
    private void init(){
        dateTime = LocalDateTime.now();
    }

    public Product() {
    }

    @ManyToMany()
    @JoinTable(name = "product_cart", joinColumns = @JoinColumn(name = "product_id"), inverseJoinColumns = @JoinColumn(name = "person_id"))
    private List<Person> personList;

    @OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
    private List<Order> orderList;

    public Product(String title, String decription, float price, String warehouse, String seller, CategoryProduct categoryProduct, LocalDateTime dateTime, List<Image> imageList) {
        this.title = title;
        this.description = decription;
        this.price = price;
        this.warehouse = warehouse;
        this.seller = seller;
        this.categoryProduct = categoryProduct;
        this.dateTime = dateTime;
        this.imageList = imageList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String decription) {
        this.description = decription;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(String warehouse) {
        this.warehouse = warehouse;
    }

    public String getSeller() {
        return seller;
    }

    public void setSeller(String seller) {
        this.seller = seller;
    }

    public CategoryProduct getCategoryProduct() {
        return categoryProduct;
    }

    public void setCategoryProduct(CategoryProduct categoryProduct) {
        this.categoryProduct = categoryProduct;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }

    public List<Image> getImageList() {
        return imageList;
    }

    public void setImageList(List<Image> imageList) {
        this.imageList = imageList;
    }
}
