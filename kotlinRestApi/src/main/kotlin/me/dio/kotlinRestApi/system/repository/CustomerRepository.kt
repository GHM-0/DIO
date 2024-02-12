package me.dio.kotlinRestApi.system.repository

import me.dio.kotlinRestApi.system.service.entity.Customer
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface CustomerRepository:JpaRepository<Customer,Long>