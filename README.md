# FlickerPhotoApp

## Workspace (Modules) layout

```
+ --- Workspace
    + --- App
    + --- API Service
    + --- Utility
    + Package Dependencies
```

I chose to use SPM (Swift Package Manager) to add only one dependency (KingFisher)
which is used to download images from web. It has also available automatic caching 
mechanism.  

## Chosen architecture

MVVM pattern is used with adding builders and presentations. 

```
+ ---- Application
    + ---- Container
        + ---- Router
            + ---- Scene
        + ---- APIService (HTTP)
            + ---- Entity
```

### App Layer

- AppDelegate: Starts and calls AppRouter.
- AppContainer: Contains app router, API service. 
- AppRouter: Creates UIWindow and starts application by calling product listing screen.

### Service

- API Service: Gets data with url session and converts photo model.

### Available Screens

- Photo Listing
- Photo Detail 
- Search

### Testing

- Unit tests
- UI tests
