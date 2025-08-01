package com.example.demo;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

public class HelloControllerTest {
    @Test
    public void sampleTest() {
        assertEquals("Hello from Secure DevOps App!", new HelloController().hello());
    }
}
