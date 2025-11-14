# Contributing to MediCare Hospital Management System

Thank you for your interest in contributing to MediCare HMS! This document provides guidelines for contributing to the project.

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers and help them get started
- Focus on constructive feedback
- Maintain professional communication

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Screenshots (if applicable)
- Environment details (OS, Java version, MySQL version)

### Suggesting Enhancements

For feature requests:
- Describe the feature clearly
- Explain why it would be useful
- Provide examples of how it would work
- Consider backward compatibility

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the coding standards below
   - Write clear commit messages
   - Add comments to complex code

4. **Test your changes**
   - Ensure all existing tests pass
   - Add new tests for new features
   - Test manually in the application

5. **Commit your changes**
   ```bash
   git commit -m "Add: Brief description of changes"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Provide a clear description
   - Reference any related issues
   - Wait for review

## Coding Standards

### Java Code Style

- Use meaningful variable and method names
- Follow camelCase for variables and methods
- Follow PascalCase for class names
- Add JavaDoc comments for public methods
- Keep methods focused and concise
- Maximum line length: 120 characters

**Example:**
```java
/**
 * Retrieves patient information by patient ID
 * @param patientId The unique identifier for the patient
 * @return Patient object containing patient details
 */
public Patient getPatientById(String patientId) {
    // Implementation
}
```

### Database

- Use meaningful table and column names
- Follow snake_case for database objects
- Add comments to complex queries
- Use prepared statements to prevent SQL injection
- Index frequently queried columns

### Frontend

- Use semantic HTML5 elements
- Follow Bootstrap conventions
- Keep JavaScript modular
- Add comments to complex logic
- Ensure responsive design

### Git Commit Messages

Format: `Type: Brief description`

**Types:**
- `Add:` New feature or functionality
- `Fix:` Bug fix
- `Update:` Modification to existing feature
- `Remove:` Deletion of code or feature
- `Refactor:` Code restructuring without changing functionality
- `Docs:` Documentation changes
- `Style:` Formatting, missing semicolons, etc.
- `Test:` Adding or updating tests

**Examples:**
```
Add: Patient search by mobile number
Fix: Login authentication error for doctors
Update: Prescription PDF generation format
Docs: Add setup instructions for Windows
```

## Development Setup

1. Follow the SETUP_GUIDE.md for initial setup
2. Create a development branch
3. Make changes and test locally
4. Submit pull request

## Testing Guidelines

### Manual Testing Checklist

- [ ] Login works for all roles
- [ ] CRUD operations function correctly
- [ ] Forms validate input properly
- [ ] Error messages display correctly
- [ ] Navigation works as expected
- [ ] Responsive design on mobile/tablet
- [ ] Print functionality works
- [ ] Database transactions commit/rollback properly

### Areas to Test

1. **Authentication**
   - Login/logout
   - Password encryption
   - Session management

2. **Administrator Module**
   - Add/edit/delete employees
   - View employee list

3. **Doctor Module**
   - View patient list
   - Access patient history
   - Generate prescriptions

4. **Receptionist Module**
   - Register patients
   - Search patients
   - Print prescriptions

## Project Structure

```
MediCareHMS/
├── src/main/java/com/healthcare/medicare/
│   ├── controller/     # MVC Controllers
│   ├── dao/           # Data Access Objects
│   ├── entity/        # JPA Entities
│   └── service/       # Business Logic (if added)
├── src/main/webapp/
│   ├── WEB-INF/
│   │   ├── view/      # JSP Views
│   │   └── *.xml      # Configuration
│   └── resources/     # Static files
├── database/          # SQL scripts
└── docs/             # Documentation
```

## Questions?

If you have questions:
- Check existing issues
- Review documentation
- Create a new issue with the "question" label

## Recognition

Contributors will be acknowledged in:
- README.md contributors section
- Release notes
- Project documentation

Thank you for contributing to MediCare HMS! 🎉
