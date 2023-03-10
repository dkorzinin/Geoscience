## Структура штормового волнения

Штормовое волнение описывается не только параметрами волн, но и их динамикой за время полного штормового цикла – от их интенсивного роста в начальную стадию и до полного затухания в конце. Штормовое волнение включает три основные фазы – развития (усиление), стабилизации и затухания (ослабление). Если в стадию развития и стабилизации происходит размыв берегового профиля, то в стадию затухания происходит частичное его восстановление. Интенсивность восстановления берегового профиля зависит от продолжительности стадии затухания шторма и от того как высоты волн в эту фазу соотносятся с высотой волны стадии развития шторма. Чем длиннее фаза затухания шторма и чем более постепенно снижается высота волны в эту фазу, тем большее количество наносов будет перенесено в сторону берега к концу штормового события.

Исходными данными для исследования являются данные реанализа [ERA5](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-single-levels?tab=form) для точки с координатами N54.5 E19, расположенной в Балтийском море у побережья Балтийской (Вислинской) косы. Исследуемый временной промежуток 42 года (1979 г – 2020 г). Частота отсчетов волновых параметров 3 часа в сутки (количество строк -  122728). Каждый отсчет включает значения Hs, м – значительная высота волны; Tm, с – средний период волн; dir, град. – румб волнения ([dataset](1979_2020.dat)). Соответствующие обозначения переменных в каталоге ERA5:

- swh - significant height of combined wind waves and swell
- mwp - mean wave period
- mwd - mean wave direction

На начальном этапе из непрерывного ряда волновых параметров извлекаются штормовые события по признаку превышения высотой волны значений 1 м ([matlab](/matlab_scripts/index_get_storm.m)). Затем полученные массивы штормовых событий можно отфильтровать по продолжительности и по интенсивности. Можно так же оставить только те штормы, для которых выделяется стадия развития или затухания (максимальное значение высоты волны не должно быть на стартовой или финальной точке). 

На начальном этапе мы получили 2263 штормовых события. В нашем случае мы выбираем только те события, для которых можно выделить стадию затухания шторма и длительность которых больше или равна 12 часов ([matlab](/matlab_scripts/choose_storm.m)). После фильтрации у нас осталось 1355 штормовых событий. Массивы всех штормовых событий могут быть для удобства упакованы в .mat файл ([matlab](/matlab_scripts/collect_month_storms.m)).

На предварительном этапе для каждого шторма определяются ряд общих метрик, которые записываются в отдельный файл ([matlab](/matlab_scripts/charact_storm_general.m)). К данным метрикам относится продолжительность шторма (T, ч), максимум, среднее значение и среднеквадратичное отклонение Hs и Tm, среднее значение и среднеквадратичное отклонение dir. Помимо этого файл содержит информацию о месяце в котором происходил шторм ([dataset](storm_char_choose_1355.txt)). Данные метрики нужны для получения общих характеристик изменения штормовой активности в течение года по месяцам. Строим распределение по месяцам максимальных значений Hs,  среднемесячных значений Hsm, средней продолжительности штормов и среднего количество штормов в каждый месяц ([python](/python_scripts/season_storm_action_analysis.ipynb)). Данный набор графиков позволяет увидеть сезонность в распределении штормовой активности.

<image
  src="/images/storm_charact_general.jpg">
*<div align="center">  Рисунок 1. Распределение штормовой активности по месяцам</div>*

  Далее для каждого шторма вычисляются метрики определяющие структуру шторма. Ранее было сказано, что чем длиннее стадия затухания волнения и чем более постепенно снижается высота волны в эту фазу, тем больше восстановительный потенциал шторма. Возникает задача - как выявить постепенное снижение волновых параметров? Одним из решений данной задачи может быть рассмотрение отношения между максимальной высотой волны шторма (Нsmax) и средним или медианным значением высоты волны в стадию затухания. Чем ближе значение данного отношения единице, тем большим потенциалом для восстановления берегового профиля обладает фаза затухания шторма. На рисунке 2 показан ход высоты волны 4-х штормов из исследуемого датасета. Данные штормы можно охарактеризовать следующими параметрами (таблица 1):
  - максимальное значение $Hs$,т.е. в пиковую фазу шторма ($Нs_{max}$);
  - средние и медианные значения $Hs$ за время стадии затухания шторма ($Hs_{mean}$ и $Hs_{med}$ соответственно);
  - значения метрик $R_{mean}$ и $R_{med}$:
 $$R_{mean} = {Нs_{max}\over Нs_{mean}};   R_{med} = {Нs_{max}\over Нs_{med}}$$
 
<div align="center">
  
| <image src = "/images/4_storms_min_2.jpg" width = "800"> | 
|:--:| 
| *Рисунок 2. Примеры 4-х штормов из исследуемого набора данных.* |
  
</div>
  
<div align="right">
  
 *Таблица 1 - Параметры характеризующие штормовые события (см. рис.2). Штормы id_126 и id_175 с высоким потенициалом для восстановления берегового профиля. Штормы id_159 и id_180 c преобладанием размыва над аккумуляцией*
  
</div>
  
  <div align="center">
  
  | storm_id | $Hs_{peak}$ | $Hs_{mean}$ | $Hs_{med}$ | $R_{mean}$ | $R_{med}$ |
  | -------- | ---- | ---- | ---- | ---- | ---- |
  | 126 | 1.75 | 1.51 | 1.61 | 1.16 | 1.08 |
  | 175 | 1.13 | 1.08 | 1.09 | 1.05 | 1.04 |
  | 159 | 3.59 | 1.87 | 1.66 | 1.92 | 2.16 |
  | 180 | 2.96 | 1.78 | 1.52 | 1.67 | 1.95 |

 </div>
  
  Для извлечение исходных данных о всех штормах в единый [датасет](matrix.txt) используется скрипт [matlab](/matlab_scripts/charact_storm.m). Исходными данными для него является файл [.mat](all_storms.mat), содержащий датасеты для каждого шторма. В дальнейшем расчет значений $R$ и статистический анализ распределения этой метрики в течение осуществляется в скрипте [python](/python_scripts/index_storm.ipynb).
  
  Согласно различиям в значениях R для рассматриваемых штормов (см. таблицу 1) события со значениями id 126 и 175 характеризуется более высоким потенциалом для восстановления профиля. Для этих штормов $R$ ближе к единице, т.е. высота волн в стадию затухания шторма не снижается относительно резко. Визуально, кривая изменений значений $Hs$ в течение стадии затухания волнения будет преимущественно выше условной линии между пиковым значением высоты волны и значением высоты волны в конечной точке шторма (прямая АА1, рисунок 2). Эти различия в большей степени выражены для коэффициента $R$, рассчитанного относительно медианного значения $Hs$ ($R_{med}$), т.к., как правило, средние значений очень чутко реагируют на выбросы. Гистограмма распределения значений $R_{mean}$ и $R_{med}$ показывает, что значения $R_{med}$ охватывают более широкий диапазон (рисунок 3), что позволит лучше выявлять различия для разных групп значений данного коэффициента. Таким образом, в дальнейшем в качестве основного показателя для оценки стадии затухания штормов будет использоваться показатель $R_{med}$ (далее обозначается как коэффициент размыва $R$). 
  
  <image
  src="/images/R_diff.jpg">
    *<div align="center">  Рисунок 3. Гистограмма распределения значений R<sub>mean</sub> и R<sub>med</sub> </div>*
 
Чтобы выявить в распределении коэффициента R сезонную динамику весь массив данных делится на отдельные датасеты по месяцам. Результаты, данного представления данных (рис.4) отражают, что для относительно высоких значений R прослеживается сезонная динамика. Особенно это выражено в количестве экстремальных выбросов, и положении верхних пределов статистически значимых величин и 75% перцентиля. В медианных значениях $R$ для каждого месяца сезонные различия тоже присутствуют, но не так выраженно как для значений, лежащих выше 3-го квартиля. 
    
  <image
  src="/images/index_storm.jpg">
    *<div align="center">  Рисунок 4. Распределение значений показателя R по месяцам </div>*
 
Согласно распределению в течение года штормовой активности (рис.1) период с мая по август условно определяется как сезон с меньшей штормовой активностью. Это позволяет сгруппировать показатели R по соответствующим периодам и сравнить их для штормового и умеренного сезонов (рис.5).
    
  <div align="center">
    
  | <image src="/images/index_season.jpg" width = "600"> |
  |:--:| 
  | *Рисунок 5. Распределение значений показателя R по типам сезонов (штормовой и умеренный)*|
    
  </div>

