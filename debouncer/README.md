# Ejemplo Git

## Descripción

Este proyecto es un ejemplo de desarrollo de un proyecto *Verilog* con *Git*. Inicialmente contiene los siguientes archivos:

* *README.md*: este archivo.
* *debouncer.v*: ejemplo de diseño de un filtro de rebotes en Verilog.
* *debouncer_tb.v*: banco de pruebas para el diseño.

## Software necesario

* Icarus Verilog: simulador de diseños Verilog.
* Gtkwave: visor de ondas.
* Git: control de versiones

## Habilidades que se practican

* Creación y configuración de un repositorio Git.
* Creación de ramas.
* Creación de confirmaciones correctas.
* Fusionado de ramas.
* Deshacer confirmaciones.
* Eliminar confirmaciones.
* Unir confirmaciones.
* Reubicación de ramas.

## Ejercicio

1. Inicialice un repositorio Git en la carpeta de trabajo y configure su nombre de usuario y correo electrónico localmente.

2. En la rama *master*, añada los archivos del proyecto (incluyendo este *README*) y cree la primera confirmación.

3. Edite los comentarios iniciales de los archivos *Verilog* para añadir su nombre y la fecha en que ha iniciado sus propios cambios. Confirme los cambios en la rama *master*.

4. Cree una rama de desarrollo *dev*. En esta rama, realice los cambios en los archivos según los ejercicios 1 y 2 del archivo *debouncer.v*. Confirme los cambios. Realice tantas confirmaciones como crea necesario.

5. Siguiendo en la rama *dev*, simule el diseño y compruebe los resultados de simulación (ejercicios 3 y 4 en *debouncer_tb.v*). Modifique el diseño hasta que los resultados de simulación sean correctos. Confirme los cambios.

6. No es necesario hacer seguimiento de archivos temporales (como *.out* o *.vcd*). En la rama *master*, cree un archivo *.gitignore* que ignore este tipo de archivos. Añada el archivo *.gitignore* al repositorio y confirme los cambios.

7. Cree una nueva rama derivada de *master* para realizar el ejercicio 6 en *debouncer_tb.v*. Esta es una rama experimental. Llámela *detectmode*. Realice al menos dos confirmaciones: una que implemente el parámetro *detect* y otra para el parámetro *mode*. Compruebe que el funcionamiento es correcto antes de hacer las confirmaciones, haciendo las modificaciones necesarias en el banco de pruebas.

8. De nuevo en la rama *dev*, modifique el banco de pruebas para que use un retraso de valor 12, tal como indica el ejercicio 5 de *debouncer_tb.v*. Compruebe el funcionamiento por simulación y confirme los cambios.

9. Sería conveniente ignorar archivos temporales también en la rama *dev*. Importe en esta rama el cambio correspondiente de la rama *master* (*cherry-pick*).

10. No parece que el retraso de 12 en el banco de pruebas esté funcionando bien. Revierta el cambio realizado en el punto 8 y que quede constancia de ello (*git revert*).

11. Pensándolo mejor, no aporta mucho tener en la historia de nuestro proyecto los cambios en el valor del retraso. Elimine de la historia las confirmaciones realizadas en el punto 8 y 10. ¿Qué funciones de Git emplearía para esto?

12. Cree una nueva rama *olddev* coincidente con *dev* con objeto de preservar su estado para uso futuro, esto es:

        $ git checkout dev
        $ git branch olddev

13. Se quiere fusionar la rama *dev* en *master* por el método de combinar todas las confirmaciones en la rama, reubicar la rama sobre *master* y luego fusionar la rama en *master* (será una fusión tipo *fast-forward*). Realice estas operaciones usando *git rebase* o las técnicas que crea convenientes.

14. Todavía no estamos seguros de querer fusionar la rama experimental *detectmode* en *master* pero sí queremos tener las actualizaciones en *master* en la rama experimental. Fusiones la rama *master* en *detectmode*. Resuelva los posibles conflictos.

Al terminar el ejercicio, generar un informe dentro de la misma carpeta del proyecto con un *log* y un *reflog* del repositorio, generado con los siguientes comandos:

    $ git log --all --decorate --graph > informe.txt
    $ git reflog >> informe.txt
