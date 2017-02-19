"""
Para que vai servir esse cara?

Assim, vou pegar uma determinada zona.
Com essa zona, vou pegar cada um dos meses.
Para cada mes, vou calcular media, mediana, quartis, etc.
Aí, para cada mês, vou plotar um boxplot para ele.
"""

import itertools
import matplotlib.pyplot as plt
from functions import cool_functions, io

load_history = io.load_load_history()
my_data = list(map(lambda row: cool_functions.raw_row_to_dict(row), load_history))
only_available_data = filter(lambda x: cool_functions.remove_non_available_data(x), my_data)

date_predicate = cool_functions.year_month_predicate(2004, 1)
zone_predicate = cool_functions.zone_predicate(9)
data = list(filter(lambda x: zone_predicate(x), filter(lambda x: date_predicate(x), only_available_data)))

to_plot = list(map(lambda x: x['hours'], data))


plt.figure()
plt.hold = True
plt.boxplot(to_plot,vert=1)
plt.show()
