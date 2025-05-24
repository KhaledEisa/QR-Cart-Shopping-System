
# Khaled Sherif Eissa 221010359
# Sohila Mohamed Helmi Alnahas 211005900
library(opencv)
library(qrcode)
library(beepr)

# Data Input (CSV format)
file_path <- file.choose()
data <- data.frame(read.csv(file_path))
data$Item <- as.numeric(data$Item)
data$Quantity <- as.numeric(data$Quantity)

# A vector to store the scanned items so then we can iterate through them to
# prepare the reciept.
scanned_item_ids <- c()
# Welcome messages + Hint + cat is used throughout the code to print objects
cat("\n--- Welcome to QART! ---\n")
cat("Scan Item QrCode. Scan ID to finish.\n")

while (TRUE) {
  cat("Scan item: ")
  input_val <- opencv::qr_scanner() 
  
  # Convert Scanned Values to numeric formats
  user_choice <- as.numeric(input_val)
  
  if (is.na(user_choice)) {
    cat("Invalid input. Please enter a number.\n")
    beepr::beep(7)
    next
  }
  if (user_choice == 0) {
    cat("Finished scanning.\n\n")
    break
  }
  
  # Find the row index for the scanned item
  item_row_index <- which(data$Item == user_choice)
  
  # Check if the item was found in the dataset
  if (length(item_row_index) > 0) {
    
    # Check if the item is in stock (quantity > 0)
    if (data$Quantity[item_row_index] > 0) {
      beepr::beep(1)
      # Add user_choice to the scanned_item_ids
      scanned_item_ids <- c(scanned_item_ids, user_choice)
      # Decrement the quantity of scanned item
      data$Quantity[item_row_index] <- data$Quantity[item_row_index] - 1
      item_info <- data[item_row_index, ]
      # Isolate item price in a variable
      item_price <- item_info$Price
      # Print user selection to check scanning validity
      cat(sprintf("  -> Scanned Item: %d\n", user_choice))
      
      # Show a warning message if the quantity remaining is 1
      if(data$Quantity[item_row_index] == 1){
        cat(sprintf("  Warning: Only 1 Piece of Item # %d Left!\n", user_choice))
      }
      # No 'else' needed here.
      
    } else { # Item quantity is 0 (Out of Stock)
      cat(sprintf("  Error: Item # %d is out of stock!\n", user_choice))
      beepr::beep(7) # Error sound
    }
    
  } else { # Item was not in the dataset
    cat(sprintf("  -> Error: Item # %d not found in dataset.\n", user_choice))
    beepr::beep(7)
  }
  # Correct closing brace for the while loop
} # End of while loop

# Reciept
if (length(scanned_item_ids) > 0) {
  tab <- table(scanned_item_ids)
  items  <- as.integer(names(tab))
  qtys   <- as.integer(tab)
  prices <- data$Price[match(items, data$Item)]
  totals <- qtys * prices
  subtotal <- sum(totals)
  tax      <- subtotal * 0.14
  total    <- subtotal + tax
  
  cat("--- Generating Receipt ---\n",
      "Item Qty x Item #     Total Price\n",
      "------------------------------------\n",
      paste(sprintf("%-4d x Item %-8d $%.2f", qtys, items, totals), collapse = "\n"), "\n",
      "------------------------------------\n",
      sprintf("Number of Items:       %d\nSubtotal:             $%.2f\nMean Item Price:      $%.2f\nMin Item Price:       $%.2f\nMax Item Price:       $%.2f\nTax (14%%):            $%.2f\n====================================\nTotal Required to Pay: $%.2f\n====================================\n\n",
              sum(qtys), subtotal, mean(rep(prices, qtys)), min(prices), max(prices), tax, total),
      sep = "")
} else {
  cat("No items scanned to generate a receipt.\n\n")
}

# Inventory check for low-stock items
cat("--- Inventory Check ---\n")
low <- subset(data, Quantity < 10)
if (nrow(low) > 0) {
  cat(sprintf("Restock Required (Quantity < %d):\n",
              10),
      paste(sprintf("  - Item: %d, Price: $%.2f, Quantity Left: %d",
                    low$Item, low$Price, low$Quantity), collapse = "\n"),
      "\n", sep = "")
} else {
  cat(sprintf("No items currently require restocking (all quantities >= %d).\n",
              10))
}



#Save updated inventory back to a CSV file
write.csv(data, file_path, row.names = FALSE)