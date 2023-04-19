package com.example.attestacionspring.services;

import com.example.attestacionspring.models.CategoryProduct;
import com.example.attestacionspring.models.Product;
import com.example.attestacionspring.repositories.ProductRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class ProductService {
    private final  ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    // Данный метод позволяет получить список всех товаров
    public List<Product> getAllProduct(){
        return productRepository.findAll();
    }

    // Данный метод позволяет получить товар по id
    public  Product getProductId(int id){
        Optional<Product> optionalProduct = productRepository.findById(id);
        return optionalProduct.orElse(null);
    }

    // Данный метод позволяет сохранить товар
    @Transactional
    public void saveProduct(Product product, CategoryProduct categoryProduct){
        product.setCategoryProduct(categoryProduct);
        productRepository.save(product);
    }

    // данный метод позволяет обновить данные о товаре
    @Transactional
    public void updateProduct (int id, Product product){
        product.setId(id);
        productRepository.save(product);
    }

    // Данный метод позволяет удалить товар по его ID
    @Transactional
    public void deleteProduct(int id){
        productRepository.deleteById(id);
    }

}
