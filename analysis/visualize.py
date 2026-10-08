##	Task 11 - Two visualizations (analysis/visualize.py)

"""Question 1. "Comparison between payment method and return rate"

- Chart Type: Bar Chart (three bars: CARD, UPI, COD)
- Finding to communicate: "COD Returns are Higher than any other Payment method"
"""

# Generate a matplotlib bar chart using a DataFrame called orders_clean.

# Data preparation:
# - Group orders_clean by 'payment_method'
# - Calculate return rate for each payment method using the 'returned' column
# - Return rate = mean of 'returned' × 100
# - Payment methods: COD, CARD, UPI
# - Sort bars by return rate in descending order
# - Finding to communicate: "COD Returns are approximately 3x Higher than Card Returns"

# Chart:
# - One bar per payment method (3 bars total)
# - COD bar colour: red
# - UPI bar colour: green
# - CARD bar colour: blue
# - Add the exact return-rate percentage above every bar
#   (COD = 44.4%, CARD = 14.7%, UPI = 18.9%)
#
# Legend:
# - Include a legend showing each payment method and its exact return rate
# - Legend entries: "COD – 44.4%", "CARD – 14.7%", "UPI – 18.9%"
# - Place legend outside the chart, upper right
#
# Styling:
# - Title: "Return Rate based on Payment Method"
# - X-axis label: "Payment Method"
# - Y-axis label: "Return Rate (%)"
# - Y-axis formatted with 2 decimal place
# - Remove top and right spines
# - Figure size: 9 × 6 inches
# - tight_layout()
# - Save as 'return_rate_by_payment.png', dpi=150

import matplotlib.pyplot as plt
from matplotlib.ticker import FormatStrFormatter
from matplotlib.patches import Patch

# Calculate return rate by payment method
return_rate = (
    orders_clean.groupby('payment_method')['returned']
    .mean()
    .mul(100)
    .sort_values(ascending=False)
)

# Define colours for each payment method
colors = {
    'COD': 'red',
    'UPI': 'green',
    'CARD': 'blue'
}

# Match colours to sorted payment methods
bar_colors = [colors[method] for method in return_rate.index]

# Create bar chart
fig, ax = plt.subplots(figsize=(9, 6))

bars = ax.bar(
    return_rate.index,
    return_rate.values,
    color=bar_colors
)

# Add exact percentage above each bar
for bar, value in zip(bars, return_rate.values):
    ax.text(
        bar.get_x() + bar.get_width() / 2,
        bar.get_height(),
        f'{value:.2f}%',
        ha='center',
        va='bottom'
    )

# Title and axis labels
ax.set_title('Return Rate based on Payment Method')
ax.set_xlabel('Payment Method')
ax.set_ylabel('Return Rate (%)')

# Y-axis with 2 decimal places
ax.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))

# Remove top and right spines
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)

# Create legend with exact percentages
legend_handles = [
    Patch(
        facecolor='red',
        label=f'COD – {return_rate["COD"]:.2f}%'
    ),
    Patch(
        facecolor='blue',
        label=f'CARD – {return_rate["CARD"]:.2f}%'
    ),
    Patch(
        facecolor='green',
        label=f'UPI – {return_rate["UPI"]:.2f}%'
    )
]

# Place legend outside the chart
ax.legend(
    handles=legend_handles,
    loc='upper left',
    bbox_to_anchor=(1.02, 1)
)

plt.tight_layout()

# Save chart
plt.savefig(
    'return_rate_by_payment.png',
    dpi=150,
    bbox_inches='tight'
)

plt.show()

"""**Question 2** : Monthly Revenue Trends post cleanup
- Chart Type: Line Chart
- Finding to communicate: "March 2026 is the actual peak month after removing quantity outliers."

"""

# Generate a matplotlib line chart using a DataFrame called orders_clean.

# Data preparation:
# - Use 'year_month' for the monthly time period
# - Use 'order_value' to calculate monthly total order value
# - Exclude rows where 'is_outlier' is True
# - Calculate the corrected monthly total order_value
# - Actual peak month: March 2026
# - Actual peak monthly order value: ₹20,318.90
# - Finding to communicate: "March 2026 is the actual peak month after removing quantity outliers."

# Chart:
# - Use a line chart showing monthly order value from January to June 2026
# - X-axis: Year-Month
# - Y-axis: Monthly Order Value
# - Add a data label for every month showing the exact order value in ₹
# - Add an annotation pointing to the March 2026 data point
# - Annotation text: "Actual Peak: March 2026 – ₹20,318.90"
# - Position the annotation clearly inside the plot area, above the March data point
# - Keep sufficient space between the annotation and the chart title
# - Use an arrow pointing directly to the March 2026 peak
# - Do not allow the annotation or arrow to overlap the title

# Styling:
# - Title: "Monthly Order Value – Actual Peak: March 2026"
# - X-axis label: "Month"
# - Y-axis label: "Order Value (₹)"
# - Y-axis formatted with comma separators
# - Remove top and right spines
# - Add extra top margin inside the figure so the annotation remains separate from the title
# - Figure size: 9 × 6 inches
# - Use tight_layout()
# - Save as 'monthly_revenue_trend.png', dpi=150

import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

# Calculate monthly order value excluding outliers
monthly_corrected = (
    orders_clean[~orders_clean['is_outlier']]
    .groupby('year_month')['order_value']
    .sum()
    .round(2)
)

# Convert months to strings for the x-axis
months = monthly_corrected.index.astype(str)
values = monthly_corrected.values

# Find actual peak
peak_index = monthly_corrected.values.argmax()
peak_month = months[peak_index]
peak_value = values[peak_index]

# Create figure
fig, ax = plt.subplots(figsize=(9, 6))

# Line chart
ax.plot(
    months,
    values,
    marker='o',
    linewidth=2
)

# Add value labels above each point
for month, value in zip(months, values):
    ax.annotate(
        f'₹{value:,.2f}',
        (month, value),
        xytext=(0, 8),
        textcoords='offset points',
        ha='center',
        fontsize=9
    )

# Add peak annotation
ax.annotate(
    f'Actual Peak: {peak_month} – ₹{peak_value:,.2f}',
    xy=(peak_month, peak_value),
    xytext=(35, 25),
    textcoords='offset points',
    ha='left',
    va='bottom',
    arrowprops=dict(
        arrowstyle='->',
        connectionstyle='arc3'
    ),
    fontsize=10
)

# Title and axis labels
ax.set_title(
    'Monthly Order Value – Actual Peak: March 2026',
    pad=20
)

ax.set_xlabel('Month')
ax.set_ylabel('Order Value (₹)')

# Format Y-axis
ax.yaxis.set_major_formatter(
    FuncFormatter(lambda x, pos: f'₹{x:,.0f}')
)

# Remove top and right spines
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)

# Give the plot additional space at the top
ax.margins(y=0.15)

# Extra separation between title and plot
plt.subplots_adjust(top=0.85)

plt.tight_layout()

# Save chart
plt.savefig(
    'monthly_revenue_trend.png',
    dpi=150,
    bbox_inches='tight'
)
