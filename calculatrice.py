def addition(a :float, b :float) -> float:
    return a + b

def soustraction(a :float, b :float)-> float:
    return a - b

def multiplication(a :float, b :float) -> float:
    return a * b

def division(a :float, b :float):
    if b != 0:
        return a / b
    return "Division par 0 impossible"