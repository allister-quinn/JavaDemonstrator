package com.allisterquinn.learning;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MyClass {

    Logger logger = LoggerFactory.getLogger(MyClass.class);

    public int myFunction() {
        logger.info("TO THE MOON");
        return 42;
    }
}
