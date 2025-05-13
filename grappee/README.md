# Grappee

A command-line tool for automating Grappus project setup.

## Installation

```bash
dart pub global activate grappee
```

## Usage

### Create a new project

```bash
grappee create --name my_app --org com.grappus --template basic
```

### Set up architecture in an existing project

```bash
# Navigate to your project directory
cd my_project

# Set up the architecture
grappee setup --architecture clean
```

## Available Commands

- `create`: Create a new Grappus project with standardized architecture
- `setup`: Set up Grappus architecture in an existing project

## Architecture Options

- `clean`: Clean Architecture with BLoC pattern
- `mvvm`: Model-View-ViewModel pattern
- `bloc`: BLoC-focused architecture

## Contributing

Please follow the Grappus contribution guidelines. 