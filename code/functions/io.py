import csv


def load_load_history():
    load_history = csv.reader(open('../../datasets/Load_history.csv'))
    header = next(load_history)
    return load_history
