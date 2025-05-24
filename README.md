# QART: QR-Code Based Shopping Cart

An interactive R script that enables command-line shopping via QR-code scanning, inventory management, and receipt generation.

## 🔍 Overview

QART ("Scan Smart, Shop Fast") lets you:

* **Load** inventory from a CSV file (`Item`, `Price`, `Quantity`).
* **Scan** product QR-codes using your webcam (`opencv::qr_scanner()`).
* **Manage** a virtual shopping cart with real-time stock updates.
* **Generate** a detailed receipt with itemized totals, tax calculation, and summary statistics.
* **Alert** for low-stock items below a configurable threshold.

## ⚙️ Features

* **CSV-Driven Inventory**: Reads and writes back to the same CSV file, keeping inventory up to date.
* **Real-Time QR Scanning**: Uses `opencv` for live QR-code detection.
* **Audio Feedback**: Confirmation and error sounds via `beepr`.
* **Input Validation**: Handles non-numeric entries, out-of-stock items, and invalid IDs gracefully.
* **Receipt Output**:

  * Item quantities and per-item totals
  * Subtotal, 14% tax, and grand total
  * Number of items, mean/min/max item price
* **Low-Stock Alerts**: Lists items with `Quantity < 10` after checkout.

## 🛠️ Prerequisites

* **R** (version 4.x or higher)
* R packages:

  * `opencv`
  * `qrcode`
  * `beepr`

Install required packages:

```r
install.packages(c("opencv", "qrcode", "beepr"))
```

## 🚀 Installation & Setup

1. **Clone the repository**

   ```bash
   ```

git clone https://github.com/KhaledEisa/QR-Cart-Shopping-System.git
cd QR-Cart-Shopping-System

````
2. **Open R or RStudio**
3. **Run the script**
   ```r
source("qart.R")
````

4. **Select your inventory CSV** when prompted (must have `Item`, `Price`, `Quantity` columns).

## 🎯 Usage

* **Scan**: Present QR codes one by one in front of your webcam.
* **Finish**: Enter or scan `0` to end scanning and generate the receipt.
* **Receipt**: View itemized totals and summary in the console.
* **Restock Alerts**: Check for low-stock items printed at the end.

## 📁 CSV Format Example

| Item | Price | Quantity |
| ---- | ----- | -------- |
| 101  | 2.50  | 15       |
| 102  | 4.75  | 8        |
| 103  | 1.20  | 20       |

* **Item**: Numeric ID encoded in QR codes.
* **Price**: Numeric value (e.g., `2.50`).
* **Quantity**: Integer stock count.

## ⚙️ Configuration

* **Low-Stock Threshold**: Default is `10`. Modify in the script:

  ```r
  low_threshold <- 10
  ```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -m "Add feature"`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 👤 Author

**Khaled Sherif Eissa** 

---

*Happy scanning!*
