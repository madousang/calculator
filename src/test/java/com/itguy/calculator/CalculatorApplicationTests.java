package com.itguy.calculator;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class CalculatorApplicationTests {

	private final Calculator calculator = new Calculator();

	@Test
	void testSum() {
		assertEquals(5, calculator.sum(2, 3));
	}
}
