package com.example.attestacionspring.controllers;

import com.example.attestacionspring.enumm.Status;
import com.example.attestacionspring.models.Cart;
import com.example.attestacionspring.models.Order;
import com.example.attestacionspring.models.Person;
import com.example.attestacionspring.models.Product;
import com.example.attestacionspring.repositories.CartRepository;
import com.example.attestacionspring.repositories.OrderRepository;
import com.example.attestacionspring.repositories.ProductRepository;
import com.example.attestacionspring.security.PersonDetails;
import com.example.attestacionspring.services.PersonService;
import com.example.attestacionspring.services.ProductService;
import com.example.attestacionspring.util.PersonValidator;
import jakarta.validation.Valid;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
public class MainController {

    private final ProductRepository productRepository;
    private  final PersonValidator personValidator;
    private final PersonService personService;
    private final ProductService productService;
    private final CartRepository cartRepository;
    private final OrderRepository orderRepository;

    public MainController(ProductRepository productRepository, PersonValidator personValidator, PersonService personService, ProductService productService, CartRepository cartRepository, OrderRepository orderRepository) {
        this.productRepository = productRepository;
        this.personValidator = personValidator;
        this.personService = personService;
        this.productService = productService;
        this.cartRepository = cartRepository;
        this.orderRepository = orderRepository;
    }

    @GetMapping("/personAccount")
    public String index(Model model){
        //Получаем объект аутентификации -> с помощью SpringContextholder обращаемся к контексту и на нём вызываем метод аутентификации. Из сессии текущего пользователя получаем объект, который был положен в данную сессию после аутентификации пользователя
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
        String role = personDetails.getPerson().getRole();
        if(role.equals("ROLE_ADMIN")){
            return "redirect:/admin";
        }
//        System.out.println(personDetails.getPerson());
//        System.out.println("ID пользователя: " + personDetails.getPerson().getId());
//        System.out.println("Логин пользователя: " + personDetails.getPerson().getLogin());
//        System.out.println("Пароль пользователя: " + personDetails.getPerson().getPassword());
        model.addAttribute("products", productService.getAllProduct());
        return "/user/index";
    }

    //Запись 1
//    @GetMapping("/registration")
//    public String registration (Model model){
//        model.addAttribute("person, new Person()");
//        return "registration";
//    }

    //Запись 2
    @GetMapping("/registration")
    public String registration (@ModelAttribute("person") Person person){
        return "registration";
    }

    @PostMapping("/registration")
    public  String resultRegistration(@ModelAttribute("person") @Valid Person person, BindingResult bindingResult) {
        personValidator.validate(person, bindingResult);
        if (bindingResult.hasErrors()) {
            return "registration";
        }
        personService.register(person);
        return "redirect:/personAccount";
    }

    @GetMapping("/personAccount/product/info/{id}")
    public String infoProduct(@PathVariable("id") int id, Model model){
        model.addAttribute("product", productService.getProductId(id));
        return "/user/infoProduct";
    }

    @PostMapping("/personAccount/product/search")
    public String productSearch(@RequestParam("search") String search, @RequestParam("ot") String ot, @RequestParam("do") String Do, @RequestParam(value = "price", required = false, defaultValue = "") String price, @RequestParam(value = "contract", required = false, defaultValue = "") String contract, Model model) {
        model.addAttribute("products", productService.getAllProduct());

        if (!ot.isEmpty() & !Do.isEmpty()) {
            if (!price.isEmpty()) {
                if (price.equals("sortedByAscendingPrice")) {
                    if (!contract.isEmpty()) {
                        if (contract.equals("furniture")) {
                            model.addAttribute("searchProduct", productRepository.findByTitleAndCategoryProductOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 1));
                        } else if (contract.equals("appLiances")) {
                            model.addAttribute("searchProduct", productRepository.findByTitleAndCategoryProductOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 3));
                        } else if (contract.equals("clothes")) {
                            model.addAttribute("searchProduct", productRepository.findByTitleAndCategoryProductOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 2));
                        }
                    } else {
                        model.addAttribute("searchProduct", productRepository.findByTitleOrderByPriceAsc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do)));
                    }
                } else if (price.equals("sortedByDescendingPrice")) {
                    if (!contract.isEmpty()) {
                        if (contract.equals("furniture")) {
                            model.addAttribute("searchProduct", productRepository.findByTitleAndCategoryProductOrderByPriceDesc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 1));
                        } else if (contract.equals("appLiances")) {
                            model.addAttribute("searchProduct", productRepository.findByTitleAndCategoryProductOrderByPriceDesc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 3));
                        } else if (contract.equals("clothes")) {
                            model.addAttribute("searchProduct", productRepository.findByTitleAndCategoryProductOrderByPriceDesc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do), 2));
                        }
                    } else {
                        model.addAttribute("searchProduct", productRepository.findByTitleOrderByPriceDesc(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do)));
                    }
                }
            }else {
                model.addAttribute("searchProduct", productRepository.findByTitleAndPriceGreaterThanEqualAndPriceLessThenEqual(search.toLowerCase(), Float.parseFloat(ot), Float.parseFloat(Do)));
            }
        }else {
            model.addAttribute("searchProduct", productRepository.findByTitleContainingIgnoreCase(search));
        }

        model.addAttribute("valueSearch", search);
        model.addAttribute("valuePriceOt", ot);
        model.addAttribute("valuePriceDo", Do);
        return "/product/product";
    }

    @GetMapping("/cart/add/{id}")
    public String addProductInCart(@PathVariable("id") int id, Model model){
            // Получаем продукт по id
        Product product = productService.getProductId(id);
            // Получаем объект аутентифицированного пользователя
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
            // получаем id пользователя из объекта
        int idPerson = personDetails.getPerson().getId();
        Cart cart = new Cart(idPerson, product.getId());
        cartRepository.save(cart);
        return "redirect:/cart";
    }

    @GetMapping("/cart")
    public String cart(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
            // получаем id пользователя из объекта
        int idPerson = personDetails.getPerson().getId();

        List<Cart> cartList = cartRepository.findByPersonId(idPerson);
        List<Product> productList = new ArrayList<>();
            // Получаем товары из корзины по id_товара
        for(Cart cart: cartList){
            productList.add(productService.getProductId(cart.getProductId()));
        }
            // Вычисление итоговой суммы товаров в корзине
        float price = 0;
        for (Product product: productList){
            price += product.getPrice();
        }
        model.addAttribute("price", price);
        model.addAttribute("cart_product", productList);
        return "/user/cart";
    }

    @GetMapping("/cart/delete/{id}")
    public String deleteProductFromCart(Model model,@PathVariable("id") int id){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
            // получаем id пользователя из объекта
        int idPerson = personDetails.getPerson().getId();
            // Получаем корзину по id_пользователя
        List<Cart> cartList = cartRepository.findByPersonId(idPerson);
        List<Product> productList = new ArrayList<>();
            // Получаем товары из корзины по id_товара
        for(Cart cart: cartList){
            productList.add(productService.getProductId(cart.getProductId()));
        }
        cartRepository.deleteCartByProductId(id);
        return "redirect:/cart";
    }

    @GetMapping("/order/create")
    public  String order(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
            // получаем id пользователя из объекта
        int idPerson = personDetails.getPerson().getId();

        List<Cart> cartList = cartRepository.findByPersonId(idPerson);
        List<Product> productList = new ArrayList<>();
            // Получаем товары из корзины по id_товара
        for(Cart cart: cartList){
            productList.add(productService.getProductId(cart.getProductId()));
        }
            // Вычисление итоговой суммы товаров в корзине
        float price = 0;
        for (Product product: productList){
            price += product.getPrice();
        }

        String uuid = UUID.randomUUID().toString();
        for(Product product : productList){
            Order newOrder = new Order(uuid, product, personDetails.getPerson(), 1, product.getPrice(), Status.Оформлен);
            orderRepository.save(newOrder);
            cartRepository.deleteCartByProductId(product.getId());
        }
        return "redirect:/orders";
    }

    @GetMapping("/orders")
    public String orderUser(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        PersonDetails personDetails = (PersonDetails) authentication.getPrincipal();
        List<Order> orderList = orderRepository.findByPerson(personDetails.getPerson());
        model.addAttribute("orders", orderList);
        return "/user/orders";
    }
}
