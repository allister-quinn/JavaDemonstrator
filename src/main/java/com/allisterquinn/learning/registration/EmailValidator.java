package com.allisterquinn.learning.registration;

import org.springframework.stereotype.Service;
import java.util.function.Predicate;

// What is a Service?
@Service
public class EmailValidator implements Predicate<String> {
    @Override
    // How does this work?
    public boolean test(String s) {
        return true;
    }
}
