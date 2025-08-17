#' Tabla de frecuencias para VACC con gráficos opcionales
#'
#' Genera la tabla de frecuencias de una variable aleatoria cuantitativa continua (VACC). A su vez, genera gráficos opcionales como histograma, ojiva, y polígono de frecuencias. Por defecto, se define el número de clases con la fórmula de Sturges.
#'
#' @param x Vector numérico.
#' @param histograma Sí es TRUE muestra el histograma de frecuencias. Por defecto es FALSE
#' @param ojiva Sí es TRUE muestra el gráfico de ojiva. Por defecto es FALSE
#' @param hyp Sí es TRUE muestra el histograma de frecuencias con polígono de frecuencias. Por defecto es FALSE
#' @param color_relleno Color de relleno
#' @param color_linea Color de la línea
#' @param color_borde Color de borde
#'
#' @return Genera una lista con 4 elementos:
#' \enumerate{
#'   \item Tabla de frecuencias
#'   \item Histograma de frecuencias
#'   \item Gráfico de ojiva
#'   \item Histograma y Polígono de frecuencias
#' }
#' @examples
#' # Devuelve tabla de frecuencias
#' vacc(x = iris$Sepal.Length)
#' # Tabla de frecuencias + histograma de frecuencias
#' vacc(x = iris$Sepal.Length, histograma = TRUE)
#' # Tabla de frecuencias + gráfico de ojiva
#' vacc(x = iris$Sepal.Length, ojiva = TRUE)
#' # Tabla de frecuencias + histograma y polígono de frecuencias
#' vacc(x = iris$Sepal.Length, hyp = TRUE)
#'
#' @import dplyr
#' @import ggplot2
#'
#' @export

vacc <- function(x, histograma = FALSE, ojiva = FALSE, hyp = FALSE,
                 color_relleno = "#E6E6E6", color_linea = "#0099CC", color_borde = "#333333") {
  if (!is.numeric(x)) stop("x debe ser numérico")

  # Ordena x de menor a mayor
  x = sort(x)
  # Defino número de clases para x
  # Fórmula de Sturges
  k = nclass.Sturges(x)
  # Valor mínimo de x
  minx = min(x)
  # Valor máximo de x
  maxx = max(x)

  repeat {
    # Defino límites de las clases
    limites = seq(minx, maxx, length.out = k + 1)
    lim_trunc = floor(limites*100)/100
    # Discretizo la variable x
    cortes = cut(x, breaks = lim_trunc, include.lowest = TRUE)

    tabla = data.frame(valor = x) %>%
      # Intervalos de clases
      mutate(limite = cortes) %>%
      count(limite, name = "fi")

    if (nrow(tabla) == k) break
    # Disminuyo número de clases si no coinciden el n° de clases con las filas de tabla
    k = k - 1
    # La bibliografía aconseja un número entre 5 y 15 clases
    if (k < 5) stop("No se pudo generar una tabla de frecuencias válida.")
  }

  li = lim_trunc[-length(lim_trunc)]
  ls = lim_trunc[-1]
  mc = round((li + ls) / 2, 2)

  tf = tabla %>%
    mutate(fr = round(fi / sum(fi), 2),
           Fi = cumsum(fi),
           Fr = round(cumsum(prop.table(fr)), 2),
           MC = mc) %>%
    rename(Clases = limite) %>%
    select(Clases, MC, fi, fr, Fi, Fr)

  # Crea gráficos pero no los imprime si es FALSE
  graf_hist = if (histograma) {
    ggplot(data.frame(valor = x), aes(x = valor)) +
      geom_histogram(breaks = limites, color = color_borde, fill = color_relleno) +
      scale_x_continuous(breaks = limites) +
      labs(title = "Histograma de Frecuencias",
           x = "Clases",
           y = "fi") +
      theme_minimal()
  } else NULL

  graf_ojiva = if (ojiva) {
    ggplot(tf, aes(x = MC, y = Fi)) +
      geom_line(linewidth = 1, colour = color_linea) +
      geom_point(size = 2, colour = color_linea) +
      scale_x_continuous(breaks = mc) +
      scale_y_continuous(breaks = tf$Fi) +
      labs(title = "Ojiva",
           x = "Marca de clase",
           y = "Fi") +
      theme_minimal()
  } else NULL

  graf_hyp = if (hyp) {
    ggplot(data.frame(valor = x), aes(x = valor)) +
      geom_histogram(breaks = limites, fill = color_relleno, color = color_borde) +
      geom_freqpoly(breaks = limites, colour = color_linea, linewidth = 1.1) +
      labs(title = "Histograma y Polígono de Frecuencias",
           x = "Clases",
           y = "fi") +
      scale_x_continuous(breaks = limites) +
      theme_minimal()
  } else NULL

  return(list(
    tf = tf,
    histograma = graf_hist,
    ojiva = graf_ojiva,
    hyp = graf_hyp
  ))
}

