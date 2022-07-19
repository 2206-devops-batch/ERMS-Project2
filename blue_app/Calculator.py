

def add(x, y):
    return float(x) + float(y)

def subtract(x, y):
    return float(x) - float(y)

def multiply(x, y):
    return float(x) * float(y)

def divide(x, y):
    """Divide Function"""
    if y == 0:
        raise ValueError('Can not divide by zero!')
    return float(x) / float(y)

