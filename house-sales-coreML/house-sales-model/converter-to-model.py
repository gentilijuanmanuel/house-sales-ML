import coremltools
from sklearn.linear_model import LinearRegression
import pandas

primaryData = pandas.read_csv("HouseSalesInCA.csv")
model = LinearRegression()
#Aca seteamos los valores de entrada y los de salida.
#Bedrooms, bathrooms y size son valores de entrada. Price es de salida.
model.fit(primaryData[["Bedrooms", "Bathrooms", "Size"]], primaryData["Price"])
coremlmodel = coremltools.converters.sklearn.convert(model, ["Bedrooms", "Bathrooms", "Size"], "Price")
coremlmodel.author = "Juan Manuel Gentili"
coremlmodel.short_description = "Este modelo calculara el precio de una casa, dependiendo del numero de habitaciones, banos y terreno en CA."
coremlmodel.license = "MIT"
coremlmodel.save("HouseSalesInCalifornia.mlmodel")