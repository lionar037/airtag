#include <iostream>
#include <cstdlib>
#include <vector>
#include <thread>
#include <chrono>
#include <string>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <unistd.h> // Necesario para la función close()

void scanDevices() {
    int device_id = hci_get_route(nullptr);
    if (device_id < 0) {
        std::cerr << "Error: No Bluetooth adapter found." << std::endl;
        return;
    }

    int sock = hci_open_dev(device_id);
    if (sock < 0) {
        std::cerr << "Error: Cannot open Bluetooth device." << std::endl;
        return;
    }

    inquiry_info* devices = nullptr;
    int max_rsp = 255;
    int len = 8;  // Scan duration
    int flags = IREQ_CACHE_FLUSH;
    int num_rsp = hci_inquiry(device_id, len, max_rsp, nullptr, &devices, flags);

    if (num_rsp < 0) {
        perror("hci_inquiry");
        return;
    }

    char addr[19] = {0};
    char name[248] = {0};

    std::cout << "Dispositivos encontrados:" << std::endl;
    for (int i = 0; i < num_rsp; i++) {
        ba2str(&(devices + i)->bdaddr, addr);
        memset(name, 0, sizeof(name));
        if (hci_read_remote_name(sock, &(devices + i)->bdaddr, sizeof(name), name, 0) < 0) {
            strcpy(name, "[desconocido]");
        }
        std::cout << "  Dirección: " << addr << ", Nombre: " << name << std::endl;
        if (std::string(name).find("Xiaomi") != std::string::npos) {
            std::cout << "Dispositivo Xiaomi encontrado: " << addr << std::endl;
            // Aquí puedes proceder a conectarte al dispositivo encontrado
        }
    }

    free(devices);
    close(sock); // Usamos close() para cerrar el socket
}

int main() {
    std::cout << "Escaneando dispositivos Bluetooth cercanos..." << std::endl;
    scanDevices();
    return 0;
}
