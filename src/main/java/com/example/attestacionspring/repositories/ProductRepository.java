package com.example.attestacionspring.repositories;

import com.example.attestacionspring.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {

    // Поиск товаров по наименованию полному или частичному независимо от регистра
    List<Product> findByTitleContainingIgnoreCase(String name);

    //Поиск по наименованию + фильтрация по диапазону цен
    @Query(value = "select  * from product where ((lower(title) LIKE %?1%) or (lower(title) LIKE '?1%') OR (lower(title) LIKE '%?1')) and (price >= ?2 and price <= ?3)", nativeQuery = true)
    List<Product> findByTitleAndPriceGreaterThanEqualAndPriceLessThenEqual(String title, float ot, float Do);

    //Поиск по наименованию + фильтрация по диапазону цен + cортировка по возрастанию цены
    @Query(value = "select * from product where (lower(title) LIKE %?1%) or (lower(title) LIKE '?1%') OR (lower(title) LIKE '%?1') and (price >= ?2 and price <= ?3) order by price", nativeQuery = true)
    List<Product> findByTitleOrderByPriceAsc(String title, float ot, float Do);

    //Поиск по наименованию + фильтрация по диапазону цен + cортировка по убыванию цены
    @Query(value = "select * from product where (lower(title) LIKE %?1%) or (lower(title) LIKE '?1%') OR (lower(title) LIKE '%?1') and (price >= ?2 and price <= ?3) order by price desc", nativeQuery = true)
    List<Product> findByTitleOrderByPriceDesc(String title, float ot, float Do);

    //Поиск по наименованию + фильтрация по диапазону цен + cортировка по возрастанию цены + категории товаров
    @Query(value = "select * from product where category_product_id = ?4 and (lower(title) LIKE %?1%) or (lower(title) LIKE '?1%') OR (lower(title) LIKE '%?1') and (price >= ?2 and price <= ?3) order by price", nativeQuery = true)
    List<Product> findByTitleAndCategoryProductOrderByPriceAsc(String title, float ot, float Do, int categoryProduct);

    //Поиск по наименованию + фильтрация по диапазону цен + cортировка по убыванию цены + категории товаров
    @Query(value = "select * from product where category_product_id = ?4 and (lower(title) LIKE %?1%) or (lower(title) LIKE '?1%') or (lower(title) LIKE '%?1') and (price >= ?2 and price <= ?3) order by price desc", nativeQuery = true)
    List<Product> findByTitleAndCategoryProductOrderByPriceDesc(String title, float ot, float Do, int categoryProduct);
}
