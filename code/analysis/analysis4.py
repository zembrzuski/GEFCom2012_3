"""
What am I going to do in this file?

It is very simple. Given a day and and two zones, I'll plot
a graphic with two subplots.
"""

import matplotlib.pyplot as plt
import numpy as np

from functions import cool_functions, graphic_functions, io

load_history = io.load_load_history()

my_data = list(map(lambda row: cool_functions.raw_row_to_dict(row), load_history))
only_available_data = filter(lambda x: cool_functions.remove_non_available_data(x), my_data)
my_data_normalized = list(map(lambda x: cool_functions.normalize(x), only_available_data))

date_predicate = cool_functions.year_month_day_predicate(2004, 1, 1)

zone1_predicate = cool_functions.zone_predicate(1)
zone2_predicate = cool_functions.zone_predicate(2)
zone3_predicate = cool_functions.zone_predicate(3)


data_chart_1 = list(filter(lambda x: zone1_predicate(x), filter(lambda x: date_predicate(x), only_available_data)))
data_chart_2 = list(filter(lambda x: zone2_predicate(x), filter(lambda x: date_predicate(x), only_available_data)))
data_chart_3 = list(filter(lambda x: zone3_predicate(x), filter(lambda x: date_predicate(x), only_available_data)))

f, (ax1, ax2, ax3) = plt.subplots(3, sharex=True, sharey=True)

ax1.set_title('Sharing both axes')
ax1.plot(data_chart_1['normalized'], label=data_chart_1['zone_id'], linewidth=2)
ax2.plot(data_chart_2['normalized'], label=data_chart_2['zone_id'], linewidth=2)
ax3.plot(data_chart_3['normalized'], label=data_chart_3['zone_id'], linewidth=2)

f.subplots_adjust(hspace=0)
plt.setp([a.get_xticklabels() for a in f.axes[:-1]], visible=False)

plt.show()