package com.allisterquinn.learning;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class MyClassTest {

    @Test
    void myFunction() {
        MyClass myClass = new MyClass();
        int i = 42;
        Assertions.assertEquals(myClass.MyFunction(), i);
    }
}