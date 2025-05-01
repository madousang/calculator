package com.itguy.calculator;

import org.springframework.stereotype.Service;
import org.springframework.cache.annotation.Cacheable;
@Service
public class Calculator {
    @Cacheable("sum")
    int sum(int a, int b) {
        return a + b;
    }
}