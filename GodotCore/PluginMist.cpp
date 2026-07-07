#include "PluginMist.h"
#include <iostream>

extern "C" {
    void Mist_InitializePlugin() {
        // এটি একটি ডামি C++ প্লাগইন ফাংশন। পরবর্তীতে Godot C++ কোড বসানো হবে।
        std::cout << "Mist Plugin Initialized on iOS!" << std::endl;
    }
}
