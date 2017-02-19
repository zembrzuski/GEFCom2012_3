"""
Isso aqui são os primeiros gráficos que fiz.

O que faz esse arquivo:
- Ele pega o dia 1 de cada mês do ano de 2005.
- Para cada dia 1, ele plota um gráfico.
- Esse gráfico contém o consumo por hora de cada uma das zonas.
- Não serve para nada isso ainda. Mas pode ser estendido e melhorado.
"""

from functions import cool_functions, graphic_functions, io

load_history = io.load_load_history()

my_data = list(map(lambda row: cool_functions.raw_row_to_dict(row), load_history))
only_available_data = filter(lambda x: cool_functions.remove_non_available_data(x), my_data)
my_data_normalized = list(map(lambda x: cool_functions.normalize(x), only_available_data))

# plota cada um dos meses
for i in range(1, 13):
    predicate = cool_functions.year_month_day_predicate(2005, i, 1)
    filtered = list(filter(lambda x: predicate(x), my_data_normalized))
    graphic_functions.save_line_chart(filtered, i)
