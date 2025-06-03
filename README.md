# 📌 **tfVACCg**

`tfVACCg` (Tabla de Frecuencias para Variables Aleatorias Cuantitativas Continuas con Gráficos) es un paquete en R que permite generar fácilmente tablas de frecuencias y gráficos descriptivos como histogramas, ojivas y polígonos de frecuencias.

El paquete fue desarrollado con fines educativos para estudiantes de la carrera Licenciatura en Bromatología de la Facultad de Ciencias Agrarias, Universidad Nacional de Jujuy.

# ✅ **Instalación**

Pasos para instalar el paquete `tfVACCg`:

1.  Instalar el paquete devtools (sí lo tiene instalado omitir este paso)

``` r
install.packages("devtools")
```

2.  Cargar el paquete devtools

``` r
library(devtools)
```

3.  Instalar `tfVACCg` desde GitHub

``` r
install_github("VictoriaLopezBIO/tfVACCg")
```

4.  Ingresar 1 (All) en la consola (Solo en caso de que R se lo solicite)

`Enter one or more numbers, or an empty line to skip updates: 1`

5.  Una vez instalado, cargar el paquete tfVACCg para hacer uso de la función vacc

``` r
library(tfVACCg)
```

# 🤓 **Uso básico**

``` r
# Devuelve tabla de frecuencias
vacc(x = iris$Sepal.Length)
# Tabla de frecuencias + histograma de frecuencias
vacc(x = iris$Sepal.Length, histograma = TRUE)
# Tabla de frecuencias + gráfico de ojiva
vacc(x = iris$Sepal.Length, ojiva = TRUE)
# Tabla de frecuencias + histograma y polígono de frecuencias
vacc(x = iris$Sepal.Length, hyp = TRUE)
```

# 🌸 **Autoría**

**María Victoria López**

Cátedra de Bioestadística y Diseño Experimental – Facultad de Ciencias Agrarias – Universidad Nacional de Jujuy

✉️ [mariavictorialopez\@fca.unju.edu.ar](mailto:mariavictorialopez@fca.unju.edu.ar)
