"""
O que deve fazer esse arquivo?

Eu acho que vou pegar uma determinada zona.
E então vou plotar um mês inteiro para cada zona.
Daí, se der, vou repetir isso para cada mês.
"""

import itertools
import matplotlib.pyplot as plt
from functions import cool_functions, io

load_history = io.load_load_history()

my_data = list(map(lambda row: cool_functions.raw_row_to_dict(row), load_history))
only_available_data = filter(lambda x: cool_functions.remove_non_available_data(x), my_data)

date_predicate = cool_functions.year_month_predicate(2004, 1)
#date_predicate = cool_functions.year_predicate(2004)
zone_predicate = cool_functions.zone_predicate(1)
data = list(filter(lambda x: zone_predicate(x), filter(lambda x: date_predicate(x), only_available_data)))
all_month = list(itertools.chain.from_iterable(list(map(lambda x: x['hours'], data))))

fig, ax = plt.subplots()

ax.plot(all_month, linewidth=1)
plt.show()
