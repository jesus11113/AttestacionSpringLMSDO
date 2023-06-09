PGDMP         8                {            TestShop    15.1    15.1 5    5           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            6           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            7           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            8           1262    16775    TestShop    DATABASE     ~   CREATE DATABASE "TestShop" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "TestShop";
                postgres    false            �            1259    16782    category_product    TABLE     c   CREATE TABLE public.category_product (
    id integer NOT NULL,
    name character varying(255)
);
 $   DROP TABLE public.category_product;
       public         heap    postgres    false            �            1259    16785    category_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.category_product_id_seq;
       public          postgres    false    214            9           0    0    category_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.category_product_id_seq OWNED BY public.category_product.id;
          public          postgres    false    215            �            1259    16786    image    TABLE     ~   CREATE TABLE public.image (
    id integer NOT NULL,
    file_name character varying(255),
    product_id integer NOT NULL
);
    DROP TABLE public.image;
       public         heap    postgres    false            �            1259    16789    image_id_seq    SEQUENCE     �   CREATE SEQUENCE public.image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.image_id_seq;
       public          postgres    false    216            :           0    0    image_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.image_id_seq OWNED BY public.image.id;
          public          postgres    false    217            �            1259    16790    orders    TABLE       CREATE TABLE public.orders (
    id integer NOT NULL,
    count integer NOT NULL,
    date_time timestamp(6) without time zone,
    number character varying(255),
    price real NOT NULL,
    status smallint,
    person_id integer NOT NULL,
    product_id integer NOT NULL
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    16793    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          postgres    false    218            ;           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          postgres    false    219            �            1259    16794    person    TABLE     �   CREATE TABLE public.person (
    id integer NOT NULL,
    login character varying(100),
    password character varying(255),
    role character varying(255)
);
    DROP TABLE public.person;
       public         heap    postgres    false            �            1259    16799    person_id_seq    SEQUENCE     �   CREATE SEQUENCE public.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.person_id_seq;
       public          postgres    false    220            <           0    0    person_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.person_id_seq OWNED BY public.person.id;
          public          postgres    false    221            �            1259    16800    product    TABLE     �  CREATE TABLE public.product (
    id integer NOT NULL,
    date_time timestamp(6) without time zone,
    description text NOT NULL,
    price real NOT NULL,
    seller character varying(255) NOT NULL,
    title text NOT NULL,
    warehouse character varying(255) NOT NULL,
    category_product_id integer NOT NULL,
    CONSTRAINT product_price_check CHECK ((price >= (1)::double precision))
);
    DROP TABLE public.product;
       public         heap    postgres    false            �            1259    16806    product_cart    TABLE     m   CREATE TABLE public.product_cart (
    id integer NOT NULL,
    person_id integer,
    product_id integer
);
     DROP TABLE public.product_cart;
       public         heap    postgres    false            �            1259    16809    product_cart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.product_cart_id_seq;
       public          postgres    false    223            =           0    0    product_cart_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.product_cart_id_seq OWNED BY public.product_cart.id;
          public          postgres    false    224            �            1259    16810    product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          postgres    false    222            >           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          postgres    false    225            ~           2604    16811    category_product id    DEFAULT     z   ALTER TABLE ONLY public.category_product ALTER COLUMN id SET DEFAULT nextval('public.category_product_id_seq'::regclass);
 B   ALTER TABLE public.category_product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214                       2604    16812    image id    DEFAULT     d   ALTER TABLE ONLY public.image ALTER COLUMN id SET DEFAULT nextval('public.image_id_seq'::regclass);
 7   ALTER TABLE public.image ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216            �           2604    16813 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218            �           2604    16814 	   person id    DEFAULT     f   ALTER TABLE ONLY public.person ALTER COLUMN id SET DEFAULT nextval('public.person_id_seq'::regclass);
 8   ALTER TABLE public.person ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220            �           2604    16815 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    222            �           2604    16816    product_cart id    DEFAULT     r   ALTER TABLE ONLY public.product_cart ALTER COLUMN id SET DEFAULT nextval('public.product_cart_id_seq'::regclass);
 >   ALTER TABLE public.product_cart ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            '          0    16782    category_product 
   TABLE DATA                 public          postgres    false    214   :       )          0    16786    image 
   TABLE DATA                 public          postgres    false    216   �:       +          0    16790    orders 
   TABLE DATA                 public          postgres    false    218   �@       -          0    16794    person 
   TABLE DATA                 public          postgres    false    220   �A       /          0    16800    product 
   TABLE DATA                 public          postgres    false    222   �B       0          0    16806    product_cart 
   TABLE DATA                 public          postgres    false    223   N[       ?           0    0    category_product_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.category_product_id_seq', 3, true);
          public          postgres    false    215            @           0    0    image_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.image_id_seq', 60, true);
          public          postgres    false    217            A           0    0    orders_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.orders_id_seq', 3, true);
          public          postgres    false    219            B           0    0    person_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.person_id_seq', 2, true);
          public          postgres    false    221            C           0    0    product_cart_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.product_cart_id_seq', 4, true);
          public          postgres    false    224            D           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 12, true);
          public          postgres    false    225            �           2606    16818 &   category_product category_product_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.category_product
    ADD CONSTRAINT category_product_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.category_product DROP CONSTRAINT category_product_pkey;
       public            postgres    false    214            �           2606    16820    image image_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.image DROP CONSTRAINT image_pkey;
       public            postgres    false    216            �           2606    16822    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    218            �           2606    16824    person person_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.person DROP CONSTRAINT person_pkey;
       public            postgres    false    220            �           2606    16826    product_cart product_cart_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.product_cart
    ADD CONSTRAINT product_cart_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.product_cart DROP CONSTRAINT product_cart_pkey;
       public            postgres    false    223            �           2606    16828    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    222            �           2606    16830 $   product uk_qka6vxqdy1dprtqnx9trdd47c 
   CONSTRAINT     `   ALTER TABLE ONLY public.product
    ADD CONSTRAINT uk_qka6vxqdy1dprtqnx9trdd47c UNIQUE (title);
 N   ALTER TABLE ONLY public.product DROP CONSTRAINT uk_qka6vxqdy1dprtqnx9trdd47c;
       public            postgres    false    222            �           2606    16831 "   orders fk1b0m4muwx1t377w9if3w6wwqn    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk1b0m4muwx1t377w9if3w6wwqn FOREIGN KEY (person_id) REFERENCES public.person(id);
 L   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk1b0m4muwx1t377w9if3w6wwqn;
       public          postgres    false    218    220    3212            �           2606    16836 "   orders fk787ibr3guwp6xobrpbofnv7le    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk787ibr3guwp6xobrpbofnv7le FOREIGN KEY (product_id) REFERENCES public.product(id);
 L   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk787ibr3guwp6xobrpbofnv7le;
       public          postgres    false    218    3214    222            �           2606    16841 !   image fkgpextbyee3uk9u6o2381m7ft1    FK CONSTRAINT     �   ALTER TABLE ONLY public.image
    ADD CONSTRAINT fkgpextbyee3uk9u6o2381m7ft1 FOREIGN KEY (product_id) REFERENCES public.product(id);
 K   ALTER TABLE ONLY public.image DROP CONSTRAINT fkgpextbyee3uk9u6o2381m7ft1;
       public          postgres    false    3214    216    222            �           2606    16846 (   product_cart fkhpnrxdy3jhujameyod08ilvvw    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_cart
    ADD CONSTRAINT fkhpnrxdy3jhujameyod08ilvvw FOREIGN KEY (product_id) REFERENCES public.product(id);
 R   ALTER TABLE ONLY public.product_cart DROP CONSTRAINT fkhpnrxdy3jhujameyod08ilvvw;
       public          postgres    false    3214    223    222            �           2606    16851 #   product fkippb821nwiaprbcw1bb77fhm0    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fkippb821nwiaprbcw1bb77fhm0 FOREIGN KEY (category_product_id) REFERENCES public.category_product(id);
 M   ALTER TABLE ONLY public.product DROP CONSTRAINT fkippb821nwiaprbcw1bb77fhm0;
       public          postgres    false    3206    222    214            �           2606    16856 (   product_cart fksgnkc1ko2i1o9yr2p63ysq3rn    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_cart
    ADD CONSTRAINT fksgnkc1ko2i1o9yr2p63ysq3rn FOREIGN KEY (person_id) REFERENCES public.person(id);
 R   ALTER TABLE ONLY public.product_cart DROP CONSTRAINT fksgnkc1ko2i1o9yr2p63ysq3rn;
       public          postgres    false    3212    220    223            '   �   x���v
Q���W((M��L�KN,IM�/��/(�O)M.Q��L�Q�K�M�Ts�	uV�0�QP�0����x��uMk.O�25���Aۀ�
�25�b�Ŧ�.l���b����b녽v\�1�� [-`g      )   �  x���Mof����+�]2�Р$R"�UYP�@�vP_������#7����0�~�������Ï������~�����������[��߾�O��������������_����_�������}���۔>=�I�hi�Stm$�5
N���:s��y���|��O����o!3��"�A������ʩ�ҡu�x�OC�sʰ��T╙�N9gP��T���KyRҲ�*L+Z ��l�В�-/R�E��T �H֥Wj6I�I�I��j��͗ˋ>Y�,5k.��3-��'E�D��i���+>rـ��dT��O���(>��n�^񹏴�ؼgRv|S�8�/����zD��W|�#Hiu�˫ȩ ����k��XQ.W|n#3�S�!Ɖ��)I^���Fu-ћ�x��}䱏��-  vGb�tBn2u��?[����F��!�f	y$6b��.Ĝ�d9����G�L�#���Ȑ �f4��Y=k����G���ěI��.�P�jW߱Z/W|�#�}�\��:���id�� �C����G���3<��q�5�\q^��H���o�Y�Yo3�~Fo;�
��%�_ӫ�"S;>,����ȣ�{�pch6�n�`�Hy�"�W~�#�~�c��gR��d��ij��i�%W~n#��O��d4�"[�01�i���(����}��O�b�;S�3�j��Y��f��\�i��G?}V�ccR6���|�L%�7��M_�<���x��4�y$[!�6(�����}��φE����B�x�.�Pzn�';���>����RE�����MĆM���Bp\�<�i�O�(?��2�.3�<ˉ��O��K�@���nc������)ռ���K���2�g��3�+B���@\�.+�>�J�>����I1�����c���&3,�;"��n�n�m��j�zE�6R�����Ё�#BE�d�ƨ}�W��#����(��`��##L�` ���=P��a~z$��x!Ă;��<���f(�.�
�}�q�� W���&�;�f\����+@���A=��Zz0�fE�z�Թ���~�� �G�9��,qe��%�VF�M�N�Hak\��<���������A���L����*{���o3�60�hQ�ulBX6v�e��P]���z�(��4t4�PfEο,ҮT��䉵�=AO`�
�Lt����6�Jf(z[�1�"������m���sD��-b'�ǲi>��L}�A�hĒ�-����SS�λc#+�}K�6�X�{ 0�b�t<kL�E��$Ϲ���{�~�hh�Z��x�b����4퓶����
=�)o��Ti�g/�+�y%|�kvL�|y�	�#"A�u�Ί��3,��TYy��=C��o�
��&LG!�6��Tc�E��gV�;��W��m�q���h�`�ι��`�)[�<t9��y�#�@�I�$*�n�n|��s�� �<�ztT����bC���$���v�{�^A��Q���*�*�#�A��w{>�%̖&D�7����S?|��^ze      +   �   x��ϱj�0��Oq[��%�Y�;u�`()4i� K2����W��C���s�_{:?.О.�0o����i	qYa?~��� ��i�E�v���`^��\����4^�?�2�ͧ������x��`�g'+�x�\T����H��v��M�Q��>�]�����=���`:�=�T1P$:��s�oI�$�C��`�gP��l�(��T�w���b��4Ǡ�*�x�F�Fh���=��C���(~ ԟ�      -   �   x���Ok�0 �"���s��N���͒�1��2bu.�%Y\*~���ؽ�ǃ��A|L�8#@���癪u'����l�p�b]�K=Z�����L|8�����0���������"�
2"�ް/�#����]},���Kym(5�����=J^ v��������vIߪ�-�f����;��e畷��t�!�Ī�$&a0:rn.��=$]%      /      x��\�nWv}�WT�N��o�t��p�D�o�=� /�"	1�eH4��4E*�MKv��#�c;�L� )6���+A���k�}�TUS�X$��Uu.��������ߺz�����o����?�޾Y}��[�܉�lߪD�n�l������q��ͻ���l�y��w���vo������hg{���_n����;�s?�t�ӝ����{g��J��/��˫oEW����F��\��V�ͨQ�6:�f��nl��^t���M��<������(���~��~��>^�Dk��b��\�o�E�n:�F����=OQ:K��|�[����N�o�8���a$/NO��I�D�8��Ov�4�hi���3ο} SrO��n���(���,���D�qC�ɻY,z2�XI�p�4J/�����=���h��ފ�pݍ�w/x�~ǟ� ��݅����}�{&o�L�i�x��O���>��n]�w"n�,��vC޼�H&\������b/=�Ks�r�Q$3>q������9Wz�n����R➊)��l���+/~(�F��4w��8�q��آ+�ﺡNݽ�@����O�V�m�l߲]����/�ܾP�G1f��q#�xncwy*+M�7�vߍ�XVܗ���)�ܛ�fl�q��R�n�~ ��}4�M�|��G���Hn��e�Ǣ�2�/��粻�F���p�i���P���=~�c�孢N�j�=7���@�N۱W"�U�s�ߤ9L��<�}cIO�έꓜ��m���1�C��h->�Z�wU`��H>�px�4���S)��h]C��X� 2O�S����jA�6�.\Lƽ��D�=�"�U7��UO19Z3>���?Ŵ�[���P�Q�Vk���֚���U��d.��y�guP�+���L��v��p�1t�>��*)A�&�!��v������L���|jIߥ��k>ń��Id�}�cU<�yT��{K8�a��!<��9n���\�gpR��
��z����lװ��=����ʊm�?�a��[6����f}ݭ�I��x�1,V��~���[b*������c�=�����c,]f��
6���!�I&�?r���~��Ş��|v.��'��ν��`JcH�J�����yp� >����~�^u�x��EW�L!���?�+�牼v��Kp�������9q(KgB_'Ahl* #8��9����^Nn��x�O�Oa�cӘC�,��fX����\Ū݊�c�� "n5�S�0���{��|����٤{u��?T�)��=���e^�E�O
FQ�1��l��,�L�s�]h�.7Aex��Ε�@ͨKTOLm���$+�2.0(>��O�,"�UG'���t .c�ͪh�rlv܉�H��1��w`��^�	d\j��j�hC������A ��2 9���O�/��5��,2p��+�µ�v�ʰ��i֪�V���qؽ^[�7�*�v�_�E�=t,�u�.L� b�T�̮��]xfF6��Ӟ*�LM�{m�dy؁�=�ٛ�9u�ԃ5 ���/����LC��L��d��'�V�=���G�ld��ţL�c(9�<巽R ^Ά�]u�y�������J��wc��W�!�� ����sc0Ǎ��J(�I�zS:,l��L���e*!�0�{��c��H��E��A�c�̎�u����~o�"^1B��#7���-�"a����O?��Z�D��W_焧�F��3�*�t�)��ݛwAK^���:�
�6�a�8��E��ayb�/���W��Y�9Õ�>��wn���sEg7c08�doW��.m��_p�����j�Oo�
	�2�����}�����4��:��P�$���HSrW�����ӏh1�Y�fӚ�-	�g�M%-9)�6�\��h����R�"fiB�x�GB9ĭY1�96X�`�B�*�kt"��@޲�P���g)]����E�@�H���Q��Ys�2cX���f�Y*y3S�{���6�)�A�JK*���@�i����>9U�M���}����7�y���Bs�W��j�Ć�� ":����9	J��9A�,�ln��h�1�/)3 AC���֘���� [rb._(�.�h�a�T('�#��<�`�������GUrP��Y�٤���4�i#�Q�=%�sBY�;"�,u��%������D?��<�Ѫ��*�q�4w�Q|�^o8�[o���5�?^����V��^�;�V�k�N�^]�l����V���n�8�̜�8a ��| [�$D�>1��r�1m�F��=�ú5�̠.� HI�MƠ�3s�d�N=Ҵ���P4�c����4�=q�b�$$	�+�$5p}4���ߴ�z>Bg	3���.BO�f$�'���o	�׊[Uh�e 
���Ǯ��a'Rou�i�����+�Gn��%��ϰߧ����~��5a�
��2ȔG�9�J�y!�n��[|!�֘��"���`����7!���G�}�̓�aH)�@���0�1��'b	����W_s����%^H�P��
P���)M�(�BPo�V*El��ms��GH:��C������<4A$��c�e�V�SNB�]OL;��մ��'0g��:�*�I�+�yf��R�c�8�*~�����[}��J��D��?xnjTW~k� II�*Vq�e�[�o�l˥,+��Dh�e�>��A@�[��IEx4c(��B☋�`?�+���l�A��n�qP���"�B-!�#��C�K�)��gd��k$.�`ne,���B�%#����C���+sij��x���1�Zl��E*1�QF"U~c����JfUL�	�H#Jj$X��^s��	�T���{��#�t,0�I�D��i ��cńq(��H�͠�ae~�ʛ�q�lp)@Vb�j���鹕�8P�!.@ؒJ���>�q;"G�'�/Y�7�0�	����z���>Ԓ�\˧=&ǘ]S�1�2�c�Tɚ����v5��PL{�d>����>"Aa/ь�f�S@>�v�cƗ�m��[kvp�]����ֽ���.���b�%h����2ZmvZ�j}��^��Qʶ^sISsIS��� i��� �-������5%�<��}���ĉ�Pr	�̠M�m�,l�#���ZL��৖)dԜsA���g��6>P���l<�-�Z+3Β(̨��Ƹ�JUl#�O��c��P.O��s�b�\��/�^.+�A��Yf��7��j���+�V��i��O�p��`�,O�:5 �RT���s����>}*A:6ǰd#����qo�"�D��Lr��K&�'_��1�\�x�S%�s��\s_6<7P�uE`2L>;�S��Hc6�f��WPذĉ$ϡf����L��@�BL�]<�~�8�0��nB�(oaUx�:���:Ծ��cm-�H�3�a���A�� z.�����L|y��cT ��3��/%���l�r^���Z���ҷ���֚Q��e��>w�F9f�u��zm�]ob�����;�ñ�e�B��fҝ���bFŌ\��E������;h��t���P8q�|�5&�c3�aќ�[�S2^Mq���,�s��c�W�D����(��
.����.�I�J�i����s��˃�v���ҟKN$W�s���_T߬E����T���� sRY�Vlio
��
�`T�f\�i�bq�j0�t��OhG}v��KO�}����(]�[M��i�{����f�<0���o	=G�u����ԩ���RV���&V<���S��<�/� !}��r����B:¬�"i�,P+��ڻ9@]9��%bS��=Y�U2��CB#~�cr^`On��t�lI���9�+���g�oYX�����Y����Z��L��d�s<���zr��5�s,y�H�[!�=��t�Xl)RzY� �� �}��&�� =���!;M�4��Y%e���K�%�ꬒKU��.�Ց�b{��-/�U�3�s��E%%N����W�r(�  �  ��E����-� 83�)���^�@l:��p��A�E��A�:�3�pΌ��)�S���$���|L��म����H���A��DS�ʃ%$z�鏭EVS�%��~�H�s#��Y�3�W.C�^��?ܼ��s����?	Rx�X��2�Z��Ս�F���t�\W3�yv�v�\K���=;n�a6r��s\�,�X
h�&se�O�n�'�o'�e�����2�R�E�0���=OY]Q�0ʲ�E;�FL�/ܯb�3m2ȕ&�!.�l��y�-I�P�7Zm�c��9�#�~���&�BDv������cz�<w��.+�f��^m4�M�_z	�����ĉ���я�@mj�L�\u&{�^Ǌ rS��k̋��!��������Z�m����;�]���
��7�'��\=�i�u�'�W��K���?���:7�k��ãő$&68�a���)gFF�e|��;[7w��U��=����K8 yV�� n��K/�"t��(C�h�,e�V�u�)kjz�â�)H=ECh�����P�s���d?�!y��zs��sؘu0��Ixq�7�F�!s�Y'���46��L-���yc8�ܫT�Z�~��F�� �D�!�(��Y��P�:i�F���_j��ާ=��x���9e��i'Y	Z���*b��:Qt5��3J.��&V�!v4]����Ih���!���Y[�a�}5<�(@�^�F�MN�`3��s�P��͉��}��z���U�%g-�&�/�8#���3� E������oq�5�@��[��5KP�g���0�U�ŢZMg���n?=0�y�������ɡ���k?�Rl�cgכ��ߪDW�|�՗�_{k� ��ق\�V�r�N�Um7�7�,*="�A����S̺zٸc�����?t��H�����c(��(<�g>6hJ�1��H� DZt�Z�����k���2ؕ�Iz��u+�U�^o��B>�c�/x�68���H���^��ǽM����\G���hj-�ЖL�A�PT���N�x���$`1����A$_W#��껑���u�Z�9-ĊlӴM
K�	p:g�C��4;�� ϟ��E�H1H��L-GXJ�v�5����z8��q����[�&Q�ey�N��������͌�7V'#
5��'C��:1�u�y����
�N��J�k'KB(�〲)��l���F=���-�`N�cM3ph�ԙ�"�i
$�t�ϭ�{Ď�@�d��¦-Х���g��u�gsKe;�7�����اu��s�>M��8�4��Ͻ�u��[�x�[*�R[��>1�^�9�NM�"��Z�Uc��*�[�D0� ����o����ok�܍[�U����ޔ����|
��!�Ņ,��3�i�NPh-~��[:����~M�-��"�A����TM�R��)q�.z���_����aY����O���7
���T�&����� Z��]�ݹ	q�m<���{�*����<ЦQ�Fxdl�/G0V?���i����D����)��O%e�C��g�4�C�!�`c)��VdI�vI֠d?�����`�[���k�K�Ѷx��(R�z��ܬ�׹W$�TwΪ�LCziO�慴P�����	�I�C�`��	����<�U�}g�v/��M{�.��������~[�-���B�l<P"w�ml�l�(��p4ah$E��Y�Ǎ�oA���<Dm��^_{j~����ӧ9�W^{yu�����j���y�F��ףF�Ӫu��f���a�'�M*�rK��L���zb&����d��ej軸Br$ECg��b�Wk�N�+��VF8��R�m�?_��}B'���ɻ�$��S];,+�h��z����=X�3��ѕx�Gѕ�ӕ�J@��7N��)G��?L�-��-e��eۡ��NL(K��ꕥ��q�S}G�~Ln�{�ʻ<\�` ���
ϊj}.�0ns�Z��d�v_�O�!�STxB�.E�F嚞�9�8��T�b��&<�͢ �9��י�>�ch�D�C��E����Y�_���\�����V�z���Gl_,��K2�e�l�e���.�H���Ȅ��,2��[j�{c{�n�J㯣��z����S	��w�|�K�(����/_8����*r�A5jh�g5���z�? {��D      0   
   x���         