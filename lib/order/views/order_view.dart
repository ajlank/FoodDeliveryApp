import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/order/hooks/fetch/order_details_fetch.dart';
import 'package:foodapp/utils/routes.dart';
import 'package:foodapp/views/auth/sign_up_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderView extends HookWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
     final accessToken = GetStorage().read('accessToken');
    if (accessToken == null) {
      return SignUpView();
    }
    
    final result = fetchOrderDetails();
    final isLoading = result.isLoading;
    final isError = result.error;

    final order = result.order;
    if (isLoading) {
      return CircularProgressIndicator();
    }

    if (isError != null) {
      return Scaffold(
        body: Center(child: Text("Error: $isError")),
      );
    }

    if (order.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No orders found")),
      );
    }

    final currentOrder = order.first; 
    final orderDate = DateFormat('MMM dd, yyyy').format(currentOrder.createdAt);
    final total = double.tryParse(currentOrder.total) ?? 0.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${currentOrder.id}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Status: ${currentOrder.deliveryStatus}",
                        style: TextStyle(
                            fontSize: 16, color: Colors.blueAccent),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Placed on: $orderDate",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Items",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: List.generate(
                  currentOrder.orderProducts.length,
                  (i) {
                    var item = currentOrder.orderProducts[i];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(item.imageUrl),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(item.title),
                      subtitle: Text("Qty: ${item.quantity}"),
                      trailing: Text(
                        "\$${(item.price * item.quantity).toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed(orderTrackRoute);
                    context.push(orderTrackRoute);
                    // context.push(mapScreenRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Track Order",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),

            
            ],
          ),
        ),
      ),
    );
  }
}
