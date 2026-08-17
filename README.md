# Gimnasio App

Aplicación Flutter desarrollada para el laboratorio E02.

## Objetivo

Aplicar conceptos de arquitectura por capas, modelado de dominio,
objetos de valor, estados sellados, repositorios y pruebas automatizadas.

El proyecto administra membresías de un gimnasio a partir de datos
almacenados localmente en formato JSON.

## Arquitectura

El proyecto está organizado por funcionalidades:

```text
lib/
└── core/
    └── features/
        └── membresias/
            ├── data/
            ├── domain/
            └── presentation/