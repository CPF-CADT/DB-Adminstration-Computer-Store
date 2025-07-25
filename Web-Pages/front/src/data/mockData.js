import G713PI from '../assets/G713PI.jpg';
import cpuImg from '../assets/CustomPc/cpu.png';
import gpuImg from '../assets/CustomPc/gpu.png';
import motherboardImg from '../assets/CustomPc/motherboard.png'; // Use actual motherboard image
import ramImg from '../assets/CustomPc/ram.png';
import psuImg from '../assets/CustomPc/psu.png'; // Use actual psu image
import coolerImg from '../assets/CustomPc/cooler.png';
import caseImg from '../assets/CustomPc/case.png';
import fanImg from '../assets/CustomPc/fan.png';

// Homepage Specific Data
export const homePageLaptops = [
  {
    product_code: "HOME-ASUS-G713PI",
    name: "ASUS ROG Strix G17 | G713PI",
    image_path: G713PI,
    price: { amount: "1899.00", currency: "USD" },
    description: "AMD R9-7945HX, 64GB DDR5 RAM, 1TB SSD, RTX 4070",
    brand: "ASUS",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "10.00" },
    feedback: { rating: "4.5", totalReview: 5 },
  },
  {
    product_code: "HOME-MSI-RAIDER",
    name: "MSI Raider GE78 HX",
    image_path: G713PI,
    price: { amount: "2499.00", currency: "USD" },
    description: "Intel i9-13980HX, 32GB RAM, 2TB SSD, RTX 4090",
    brand: "MSI",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "15.00" },
    feedback: { rating: "4.8", totalReview: 8 },
  },
  {
    product_code: "HOME-LENOVO-LEGION",
    name: "Lenovo Legion Pro 7i",
    image_path: G713PI,
    price: { amount: "2199.00", currency: "USD" },
    description: "Intel i9-13900HX, 32GB RAM, 1TB SSD, RTX 4080",
    brand: "Lenovo",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "12.00" },
    feedback: { rating: "4.7", totalReview: 6 },
  }
];

// Home page latest products (different from Laptop page latest products)
export const homeLatestProducts = [
  {
    product_code: "HOME-LATEST-ROG",
    name: "ASUS ROG Flow X16",
    image_path: G713PI,
    price: { amount: "2799.00", currency: "USD" },
    description: "NEW! AMD R9-7945HX, 64GB DDR5, RTX 4090",
    brand: "ASUS",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "8.00" },
    feedback: { rating: "5.0", totalReview: 3 },
  },
    {
    product_code: "HOME-LATEST-ROG",
    name: "ASUS ROG Flow X16",
    image_path: G713PI,
    price: { amount: "2799.00", currency: "USD" },
    description: "NEW! AMD R9-7945HX, 64GB DDR5, RTX 4090",
    brand: "ASUS",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "8.00" },
    feedback: { rating: "5.0", totalReview: 3 },
  },
  {
    product_code: "HOME-LATEST-ALIENWARE",
    name: "Alienware x16 R2",
    image_path: G713PI,
    price: { amount: "3299.00", currency: "USD" },
    description: "NEW! Intel i9-14900HX, 64GB DDR5, RTX 4090",
    brand: "Alienware",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "5.00" },
    feedback: { rating: "4.9", totalReview: 2 },
  }
];

// Laptop Page Main Catalog
export const mockLaptop = [
  {
    product_code: "ROG-STRIX-G17",
    name: "ROG STRIX G17",
    image_path: G713PI,
    price: { amount: "1999.00", currency: "USD" },
    description: "AMD R9-7945HX, 64GB DDR5 RAM, 1TB SSD, RTX 4070, 17.3'' 240Hz",
    brand: "ASUS",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "5.00" },
    feedback: { rating: "4.8", totalReview: 12 },
  },
    {
    product_code: "ROG-STRIX-G17",
    name: "ROG STRIX G17",
    image_path: G713PI,
    price: { amount: "1999.00", currency: "USD" },
    description: "AMD R9-7945HX, 64GB DDR5 RAM, 1TB SSD, RTX 4070, 17.3'' 240Hz",
    brand: "ASUS",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "5.00" },
    feedback: { rating: "4.8", totalReview: 12 },
  },
  {
    product_code: "ROG-ZEPHYRUS",
    name: "ROG Zephyrus G14",
    image_path: G713PI,
    price: { amount: "1599.00", currency: "USD" },
    description: "AMD Ryzen 9, 32GB RAM, 1TB SSD, RTX 4060, 14'' QHD, Windows 11 Home",
    brand: "ASUS",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "12.00" },
    feedback: { rating: "4.7", totalReview: 8 },
  },
  {
    product_code: "ROG-STRIX-SCAR",
    name: "ROG Strix SCAR 17",
    image_path: G713PI,
    price: {
      amount: "799.00",
      currency: "USD",
    },
    description: "Intel i5, 16GB RAM, 512GB SSD, Intel Iris Xe, 15.6'' FHD, Windows 11 Home",
    brand: "ASUS",
    category: {
      id: 1,
      title: "Laptops",
    },
    type: {
      id: 2,
      title: "Ultrabook",
    },
    discount: {
      type: "Percentage",
      value: "5.00",
    },
    feedback: {
      rating: "4.2",
      totalReview: 3,
    },
  },
  {
    product_code: "ASUS-TUF-A15",
    name: "ASUS TUF Gaming A15",
    image_path: G713PI,
    price: { amount: "1299.00", currency: "USD" },
    description: "AMD Ryzen 7 6800H, 16GB RAM, 512GB SSD, RTX 3060, 15.6'' 144Hz, Windows 11",
    brand: "ASUS",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "15.00" },
    feedback: { rating: "4.6", totalReview: 15 },
  },
  {
    product_code: "MSI-RAIDER",
    name: "MSI Raider GE78 HX",
    image_path: G713PI,
    price: { amount: "2899.00", currency: "USD" },
    description: "Intel i9-13980HX, 32GB RAM, 2TB SSD, RTX 4080, 17'' QHD+, Windows 11",
    brand: "MSI",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "7.00" },
    feedback: { rating: "4.8", totalReview: 6 },
  }
];

// Latest Products Sidebar for Laptop Page
export const latestProducts = [
  {
    product_code: "LATEST-ASUS-G713PI",
    name: "ASUS ROG Strix G17 (2024)",
    image_path: G713PI,
    price: { amount: "2199.00", currency: "USD" },
    description: "NEW! AMD R9-7945HX, 64GB DDR5, RTX 4080",
    brand: "ASUS",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "5.00" },
    feedback: { rating: "5.0", totalReview: 2 },
  },
  {
    product_code: "MSI-TITAN-NEW",
    name: "MSI Titan GT77 (2024)",
    image_path: G713PI,
    price: { amount: "3499.00", currency: "USD" },
    description: "NEW! Intel i9-13980HX, 64GB DDR5, RTX 4090",
    brand: "MSI",
    category: { id: 1, title: "Laptops" },
    type: { id: 1, title: "Gaming Laptop" },
    discount: { type: "Percentage", value: "8.00" },
    feedback: { rating: "4.9", totalReview: 3 },
  },
  // Keep 3 items for Latest Products sidebar
];

// PC Page Data
export const mockPC = [
  {
    product_code: "PC-ULTIMATE",
    name: "Ultimate Gaming PC",
    image_path: G713PI, // Use G713PI as placeholder
    price: {
      amount: "2499.00",
      currency: "USD",
    },
    description: "Intel i9-13900K, 64GB RAM, 2TB SSD, RTX 4090, Windows 11 Pro",
    brand: "Custom",
    category: {
      id: 2,
      title: "Desktops",
    },
    type: {
      id: 1,
      title: "Gaming PC",
    },
    discount: {
      type: "Percentage",
      value: "8.00",
    },
    feedback: {
      rating: "5.0",
      totalReview: 12,
    },
  },
  {
    product_code: "PC-STREAMER",
    name: "Streamer Pro PC",
    image_path: G713PI, // Use G713PI as placeholder
    price: {
      amount: "1799.00",
      currency: "USD",
    },
    description: "AMD Ryzen 7 7800X, 32GB RAM, 1TB SSD, RTX 4070, Windows 11 Home",
    brand: "Custom",
    category: {
      id: 2,
      title: "Desktops",
    },
    type: {
      id: 2,
      title: "Streaming PC",
    },
    discount: {
      type: "Percentage",
      value: "10.00",
    },
    feedback: {
      rating: "4.8",
      totalReview: 7,
    },
  },
  {
    product_code: "PC-BUDGET",
    name: "Budget Office PC",
    image_path: G713PI, // Use G713PI as placeholder
    price: {
      amount: "599.00",
      currency: "USD",
    },
    description: "Intel i3, 8GB RAM, 256GB SSD, Intel UHD, Windows 11 Home",
    brand: "Custom",
    category: {
      id: 2,
      title: "Desktops",
    },
    type: {
      id: 3,
      title: "Office PC",
    },
    discount: {
      type: "Percentage",
      value: "3.00",
    },
    feedback: {
      rating: "4.0",
      totalReview: 2,
    },
  },
  
  {
    product_code: "PC-WORKSTATION",
    name: "Workstation Pro",
    image_path: G713PI,
    price: { amount: "2999.00", currency: "USD" },
    description: "Intel Xeon, 128GB RAM, 4TB SSD, RTX A6000, Windows 11 Pro",
    brand: "Custom",
    category: { id: 2, title: "Desktops" },
    type: { id: 4, title: "Workstation" },
    discount: { type: "Percentage", value: "7.00" },
    feedback: { rating: "4.9", totalReview: 4 },
  },
  {
    product_code: "PC-ENTRY",
    name: "Entry Level PC",
    image_path: G713PI,
    price: { amount: "499.00", currency: "USD" },
    description: "Intel Pentium, 4GB RAM, 128GB SSD, Windows 11 Home",
    brand: "Custom",
    category: { id: 2, title: "Desktops" },
    type: { id: 5, title: "Entry Level" },
    discount: { type: "Percentage", value: "2.00" },
    feedback: { rating: "3.8", totalReview: 1 },
  },
];

// --- Add mock PC build components for demo ---
export const mockMotherboards = [
  {
    product_code: "MB-ASUS-PRIME",
    name: "Motherboard ASUS PRIME B550M-A",
    image_path: G713PI,
    price: { amount: "109.00", currency: "USD" },
    description: "AMD B550, DDR4, mATX",
    brand: "ASUS",
    category: { id: 3, title: "Motherboard" },
    type: { id: 1, title: "ATX" },
    discount: null,
    feedback: { rating: "4.5", totalReview: 3 },
  },
  // ...add more if needed
];

export const mockCPUs = [
  {
    product_code: "CPU-INTEL-I5",
    name: "Intel Core i5-12400F",
    image_path: G713PI,
    price: { amount: "185.00", currency: "USD" },
    description: "6 Cores, 12 Threads, 4.4GHz",
    brand: "Intel",
    category: { id: 4, title: "CPU" },
    type: { id: 1, title: "Desktop CPU" },
    discount: null,
    feedback: { rating: "4.7", totalReview: 5 },
  },
  // ...add more if needed
];

export const mockGPUs = [
  {
    product_code: "GPU-RTX-4060",
    name: "NVIDIA GeForce RTX 4060",
    image_path: G713PI,
    price: { amount: "299.00", currency: "USD" },
    description: "8GB GDDR6, PCIe 4.0",
    brand: "NVIDIA",
    category: { id: 5, title: "Graphic Card" },
    type: { id: 1, title: "GPU" },
    discount: null,
    feedback: { rating: "4.8", totalReview: 7 },
  },
  // ...add more if needed
];

export const mockRAMs = [
  {
    product_code: "RAM-CORSAIR-16GB",
    name: "Corsair Vengeance 16GB DDR4",
    image_path: G713PI,
    price: { amount: "60.00", currency: "USD" },
    description: "DDR4 3200MHz",
    brand: "Corsair",
    category: { id: 6, title: "RAM" },
    type: { id: 1, title: "DDR4" },
    discount: null,
    feedback: { rating: "4.6", totalReview: 4 },
  },
];

export const mockPSUs = [
  {
    product_code: "PSU-COOLERMASTER-650W",
    name: "Cooler Master 650W Bronze",
    image_path: G713PI,
    price: { amount: "80.00", currency: "USD" },
    description: "80+ Bronze, Non-Modular",
    brand: "Cooler Master",
    category: { id: 7, title: "Power Supply" },
    type: { id: 1, title: "ATX PSU" },
    discount: null,
    feedback: { rating: "4.4", totalReview: 2 },
  },
];

export const mockFans = [
  {
    product_code: "FAN-ARCTIC-P12",
    name: "Arctic P12 PWM Fan",
    image_path: G713PI,
    price: { amount: "10.00", currency: "USD" },
    description: "120mm, PWM",
    brand: "Arctic",
    category: { id: 8, title: "Fan" },
    type: { id: 1, title: "Case Fan" },
    discount: null,
    feedback: { rating: "4.3", totalReview: 1 },
  },
];

export const mockCoolers = [
  {
    product_code: "COOLER-DEEPCOOL-GAMMAXX",
    name: "Deepcool GAMMAXX 400",
    image_path: G713PI,
    price: { amount: "30.00", currency: "USD" },
    description: "Air Cooler, 120mm",
    brand: "Deepcool",
    category: { id: 9, title: "Cooler" },
    type: { id: 1, title: "Air Cooler" },
    discount: null,
    feedback: { rating: "4.2", totalReview: 2 },
  },
];

export const mockCases = [
  {
    product_code: "CASE-NZXT-H510",
    name: "NZXT H510",
    image_path: G713PI,
    price: { amount: "70.00", currency: "USD" },
    description: "ATX Mid Tower",
    brand: "NZXT",
    category: { id: 10, title: "Case" },
    type: { id: 1, title: "ATX Case" },
    discount: null,
    feedback: { rating: "4.7", totalReview: 3 },
  },
];

// Combined products for cart and checkout
export const mockProducts = [...mockLaptop, ...mockPC];
export const mockShippingMethods = [
  { id: 'standard', name: 'Standard Shipping (5-7 Days)', price: 5.00 },
  { id: 'express', name: 'Express Shipping (2-3 Days)', price: 15.00 },
];

// --- Custom PC Builder Component Data (NEW) ---

// CPU
export const builderCPUs = [
  {
    id: 'cpu-1',
    name: 'Intel Core i9-13900K',
    image: cpuImg,
    cores: 24,
    threads: 32,
    baseClock: '3.0GHz',
    boostClock: '5.8GHz',
    price: 599,
    socket: 'LGA1700',
    brand: 'Intel',
    description: '24-core, 32-thread, 13th Gen flagship CPU.',
  },
  {
    id: 'cpu-2',
    name: 'AMD Ryzen 9 7950X',
    image: cpuImg,
    cores: 16,
    threads: 32,
    baseClock: '4.5GHz',
    boostClock: '5.7GHz',
    price: 579,
    socket: 'AM5',
    brand: 'AMD',
    description: '16-core, 32-thread, Zen 4 architecture.',
  },
  {
    id: 'cpu-3',
    name: 'Intel Core i7-13700K',
    image: cpuImg,
    cores: 16,
    threads: 24,
    baseClock: '3.4GHz',
    boostClock: '5.4GHz',
    price: 429,
    socket: 'LGA1700',
    brand: 'Intel',
    description: '16-core, 24-thread, 13th Gen performance CPU.',
  },
  {
    id: 'cpu-4',
    name: 'AMD Ryzen 7 7700X',
    image: cpuImg,
    cores: 8,
    threads: 16,
    baseClock: '4.5GHz',
    boostClock: '5.4GHz',
    price: 349,
    socket: 'AM5',
    brand: 'AMD',
    description: '8-core, 16-thread, Zen 4 gaming CPU.',
  },
  {
    id: 'cpu-5',
    name: 'Intel Core i5-12600K',
    image: cpuImg,
    cores: 10,
    threads: 16,
    baseClock: '3.7GHz',
    boostClock: '4.9GHz',
    price: 289,
    socket: 'LGA1700',
    brand: 'Intel',
    description: '10-core, 16-thread, 12th Gen value CPU.',
  },
];

// GPU
export const builderGPUs = [
  {
    id: 'gpu-1',
    name: 'NVIDIA RTX 4090',
    image: gpuImg,
    vram: '24GB GDDR6X',
    price: 1599,
    brand: 'NVIDIA',
    description: 'Flagship gaming GPU, 24GB VRAM.',
  },
  {
    id: 'gpu-2',
    name: 'AMD Radeon RX 7900 XTX',
    image: gpuImg,
    vram: '24GB GDDR6',
    price: 999,
    brand: 'AMD',
    description: 'High-end AMD GPU, 24GB VRAM.',
  },
  {
    id: 'gpu-3',
    name: 'NVIDIA RTX 4070 Ti',
    image: gpuImg,
    vram: '12GB GDDR6X',
    price: 849,
    brand: 'NVIDIA',
    description: 'High-end gaming GPU, 12GB VRAM.',
  },
  {
    id: 'gpu-4',
    name: 'AMD Radeon RX 7800 XT',
    image: gpuImg,
    vram: '16GB GDDR6',
    price: 599,
    brand: 'AMD',
    description: 'Upper midrange AMD GPU, 16GB VRAM.',
  },
  {
    id: 'gpu-5',
    name: 'NVIDIA RTX 4060',
    image: gpuImg,
    vram: '8GB GDDR6',
    price: 349,
    brand: 'NVIDIA',
    description: 'Mainstream gaming GPU, 8GB VRAM.',
  },
];

// Motherboard
export const builderMotherboards = [
  {
    id: 'mb-1',
    name: 'ASUS ROG Strix Z790-E',
    image: motherboardImg,
    chipset: 'Z790',
    socket: 'LGA1700',
    price: 399,
    brand: 'ASUS',
    description: 'Premium Intel Z790 motherboard.',
  },
  {
    id: 'mb-2',
    name: 'MSI MAG B650 Tomahawk',
    image: motherboardImg,
    chipset: 'B650',
    socket: 'AM5',
    price: 229,
    brand: 'MSI',
    description: 'Mainstream AMD B650 motherboard.',
  },
  {
    id: 'mb-3',
    name: 'Gigabyte Z790 AORUS Elite',
    image: motherboardImg,
    chipset: 'Z790',
    socket: 'LGA1700',
    price: 279,
    brand: 'Gigabyte',
    description: 'Solid Intel Z790 motherboard.',
  },
  {
    id: 'mb-4',
    name: 'ASRock B650M Pro RS',
    image: motherboardImg,
    chipset: 'B650',
    socket: 'AM5',
    price: 169,
    brand: 'ASRock',
    description: 'Affordable AMD B650 micro-ATX board.',
  },
  {
    id: 'mb-5',
    name: 'MSI PRO Z690-A DDR4',
    image: motherboardImg,
    chipset: 'Z690',
    socket: 'LGA1700',
    price: 189,
    brand: 'MSI',
    description: 'Entry-level Intel Z690 motherboard.',
  },
];

// RAM
export const builderRAMs = [
  {
    id: 'ram-1',
    name: 'Corsair Vengeance 32GB DDR5',
    image: ramImg,
    size: '32GB (2x16GB)',
    speed: '6000MHz',
    price: 149,
    brand: 'Corsair',
    description: 'High-speed DDR5 RAM kit.',
  },
  {
    id: 'ram-2',
    name: 'G.Skill Trident Z 64GB DDR5',
    image: ramImg,
    size: '64GB (2x32GB)',
    speed: '6000MHz',
    price: 299,
    brand: 'G.Skill',
    description: 'High-capacity DDR5 RAM kit.',
  },
  {
    id: 'ram-3',
    name: 'Kingston Fury Beast 32GB DDR5',
    image: ramImg,
    size: '32GB (2x16GB)',
    speed: '5600MHz',
    price: 129,
    brand: 'Kingston',
    description: 'Fast DDR5 RAM kit.',
  },
  {
    id: 'ram-4',
    name: 'Corsair Vengeance 16GB DDR4',
    image: ramImg,
    size: '16GB (2x8GB)',
    speed: '3200MHz',
    price: 59,
    brand: 'Corsair',
    description: 'Popular DDR4 RAM kit.',
  },
  {
    id: 'ram-5',
    name: 'TeamGroup T-Force Delta 32GB DDR5',
    image: ramImg,
    size: '32GB (2x16GB)',
    speed: '6000MHz',
    price: 139,
    brand: 'TeamGroup',
    description: 'RGB DDR5 RAM kit.',
  },
];

// PSU
export const builderPSUs = [
  {
    id: 'psu-1',
    name: 'Corsair RM850x 850W',
    image: psuImg,
    wattage: 850,
    rating: '80+ Gold',
    price: 139,
    brand: 'Corsair',
    description: 'Fully modular, 80+ Gold certified.',
  },
  {
    id: 'psu-2',
    name: 'Seasonic Focus 750W',
    image: psuImg,
    wattage: 750,
    rating: '80+ Gold',
    price: 119,
    brand: 'Seasonic',
    description: 'Reliable, modular power supply.',
  },
  {
    id: 'psu-3',
    name: 'EVGA SuperNOVA 750 G5',
    image: psuImg,
    wattage: 750,
    rating: '80+ Gold',
    price: 129,
    brand: 'EVGA',
    description: 'Fully modular, 80+ Gold certified.',
  },
  {
    id: 'psu-4',
    name: 'Cooler Master MWE 650W',
    image: psuImg,
    wattage: 650,
    rating: '80+ Bronze',
    price: 89,
    brand: 'Cooler Master',
    description: 'Budget 650W PSU.',
  },
  {
    id: 'psu-5',
    name: 'Be Quiet! Pure Power 11 600W',
    image: psuImg,
    wattage: 600,
    rating: '80+ Gold',
    price: 99,
    brand: 'Be Quiet!',
    description: 'Quiet, efficient PSU.',
  },
];

// Cooler
export const builderCoolers = [
  {
    id: 'cooler-1',
    name: 'Noctua NH-D15',
    image: coolerImg,
    type: 'Air',
    price: 99,
    brand: 'Noctua',
    description: 'Dual-tower air cooler.',
  },
  {
    id: 'cooler-2',
    name: 'Corsair iCUE H150i',
    image: coolerImg,
    type: 'Liquid',
    price: 179,
    brand: 'Corsair',
    description: '360mm AIO liquid cooler.',
  },
  {
    id: 'cooler-3',
    name: 'be quiet! Dark Rock Pro 4',
    image: coolerImg,
    type: 'Air',
    price: 89,
    brand: 'be quiet!',
    description: 'High-end air cooler.',
  },
  {
    id: 'cooler-4',
    name: 'NZXT Kraken X63',
    image: coolerImg,
    type: 'Liquid',
    price: 149,
    brand: 'NZXT',
    description: '280mm AIO liquid cooler.',
  },
  {
    id: 'cooler-5',
    name: 'Deepcool AK620',
    image: coolerImg,
    type: 'Air',
    price: 69,
    brand: 'Deepcool',
    description: 'Dual-tower air cooler.',
  },
];

// Case
export const builderCases = [
  {
    id: 'case-1',
    name: 'NZXT H510',
    image: caseImg,
    type: 'Mid Tower',
    price: 79,
    brand: 'NZXT',
    description: 'Popular mid-tower ATX case.',
  },
  {
    id: 'case-2',
    name: 'Lian Li PC-O11 Dynamic',
    image: caseImg,
    type: 'Mid Tower',
    price: 139,
    brand: 'Lian Li',
    description: 'Showcase case for custom builds.',
  },
  {
    id: 'case-3',
    name: 'Phanteks Eclipse P400A',
    image: caseImg,
    type: 'Mid Tower',
    price: 89,
    brand: 'Phanteks',
    description: 'High airflow mid-tower case.',
  },
  {
    id: 'case-4',
    name: 'Fractal Design Meshify C',
    image: caseImg,
    type: 'Mid Tower',
    price: 99,
    brand: 'Fractal Design',
    description: 'Mesh front panel for airflow.',
  },
  {
    id: 'case-5',
    name: 'Cooler Master NR200P',
    image: caseImg,
    type: 'Mini ITX',
    price: 129,
    brand: 'Cooler Master',
    description: 'Compact Mini ITX case.',
  },
];

// Fan
export const builderFans = [
  {
    id: 'fan-1',
    name: 'Noctua NF-A12x25',
    image: fanImg,
    size: '120mm',
    price: 29,
    brand: 'Noctua',
    description: 'Premium quiet fan.',
  },
  {
    id: 'fan-2',
    name: 'Corsair LL120 RGB',
    image: fanImg,
    size: '120mm',
    price: 39,
    brand: 'Corsair',
    description: 'RGB fan for cases and radiators.',
  },
  {
    id: 'fan-3',
    name: 'be quiet! Silent Wings 3',
    image: fanImg,
    size: '120mm',
    price: 25,
    brand: 'be quiet!',
    description: 'Ultra-quiet premium fan.',
  },
  {
    id: 'fan-4',
    name: 'Arctic F12 PWM PST',
    image: fanImg,
    size: '120mm',
    price: 12,
    brand: 'Arctic',
    description: 'Affordable PWM fan.',
  },
  {
    id: 'fan-5',
    name: 'NZXT Aer RGB 2',
    image: fanImg,
    size: '120mm',
    price: 34,
    brand: 'NZXT',
    description: 'RGB fan for cases and radiators.',
  },
];