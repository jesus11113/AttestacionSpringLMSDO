package com.example.attestacionspring.config;

//import com.example.attestacionspring.security.AuthenticationProvider;
import com.example.attestacionspring.services.PersonDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig{
    private final PersonDetailsService personDetailsService;

    @Bean
    public PasswordEncoder getPasswordEncode(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{

        // Конфигурируем работу Spring Security
//        http.csrf().disable()  //отключаем защиту межсайтовой подделки запросов
        http
            .authorizeHttpRequests() // указываем, что все страницы должны быть защищены аутентификацией

//            .requestMatchers("/authentication", "/error", "/registration").permitAll() //указываем, что неаутентифицированные пользователи могут зайти на страницу аутентификации и на объект ошибки. С помощью permitAll указываем, что неаутентифицированные пользователи могут заходить на перечисленные страницы

            .requestMatchers("/admin").hasRole("ADMIN")// указываем на то, что страница /admin доступна пользователю с ролью ADMIN

            .requestMatchers("/authentication", "/registration", "/error", "/resources/**", "/static/**", "/css/**", "/js/**", "/img/**","/product", "/product/info/{id}","/product/search").permitAll()

            .anyRequest().hasAnyRole("USER", "ADMIN")

            //.anyRequest().authenticated() // Указываем, что для всех остальных страниц необходимо вызывать метод authenticated(), который открывает форму аутентификации

            .and() //Указываем, что дальше настраивается аутентификация и соединяем её с настройкой доступа

            .formLogin().loginPage("/authentication") //Указываем какой URL-запрос будет отправляться при заходе на защищённые страницы

            .loginProcessingUrl("/process_login") //указываем на какой адрес будут отправляться данные с формы. Нам не нужно будет создавать метод в контроллере и обрабатывать данные с формы. Мы задали URL, который используется по умолчанию для обработки формы аутентификации по средствам Spring Security. Spring Security будет ждать объект с формы аутентификации и затем сверять логин и пароль с данными в БД

            .defaultSuccessUrl("/personAccount", true) //Указываем на какой URL необходимо направить пользователя после успешной аутентификации. Вторым аргументом указывается true чтоьы перенаправление шло в любом случае после успешной аутентификации

            .failureUrl("/authentication?error") // Указываем куда необходимо перенаправлять пользователя при проваленной аутентификации. В запрос будет передан объект error, который будет проверяться на форме и при налиции данного объекта в запросе выводится сообщение "Неправильный логин или пароль"
            .and()
            .logout().logoutUrl("/logout").logoutSuccessUrl("/product");
        return http.build();
    }

    @Autowired
    public SecurityConfig(PersonDetailsService personDetailsService) {
        this.personDetailsService = personDetailsService;
    }
//    private  final AuthenticationProvider authenticationProvider;
//
//    public SecurityConfig(AuthenticationProvider authenticationProvider) {
//        this.authenticationProvider = authenticationProvider;
//    }

    protected void configure(AuthenticationManagerBuilder authenticationManagerBuilder) throws Exception {
//        authenticationManagerBuilder.authenticationProvider(authenticationProvider);
        authenticationManagerBuilder.userDetailsService(personDetailsService)
                .passwordEncoder(getPasswordEncode());
    }
}
