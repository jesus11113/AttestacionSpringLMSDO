package com.example.attestacionspring.repositories;

import com.example.attestacionspring.models.CategoryProduct;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<CategoryProduct, Integer> {
    com.example.attestacionspring.models.CategoryProduct findByName(String name);

}
