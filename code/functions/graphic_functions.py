import matplotlib.pyplot as plt
from matplotlib.font_manager import FontProperties


def save_line_chart(data, month):
    fig, ax = plt.subplots()

    plt.title(month)

    for i in range(20):
        ax.plot(data[i]['normalized'], label=data[i]['zone_id'])

    fontP = FontProperties()
    fontP.set_size('small')

    legend = ax.legend(bbox_to_anchor=(1.1, 1.05))

    for label in legend.get_texts():
        label.set_fontsize('small')

    #plt.show()
    plt.savefig('../graphics/{}.png'.format(month))
