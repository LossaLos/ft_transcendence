# ft_transcendence API Documentation

_Most API endpoints require a valid JWT in the header._

---


## Table of Contents

-   [Tournament Service API](#tournament-service-api)
-   [User Service API](#user-service-api)
-   [Auth Service API](#auth-service-api)
-   [Authentication Details](#authentication-details)
-   [Error Handling](#error-handling)

---

## Tournament Service API

Base URL: `/api/tournament-service/`

| Endpoint                              | Method | Description                                                                               | Parameters / Body                                              |
| ------------------------------------- | ------ | ----------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| `get_current_tournament/`             | GET    | Retrieves the currently active tournament.                                                | _None_                                                         |
| `update_match_result/`                | POST   | Updates the result of a match (e.g., after game completion).                              | JSON payload with match result details (e.g., game_id, scores) |
| `abandon_local_tournament/`           | POST   | Abandons a local tournament for a user.                                                   | JSON payload with user identifier and tournament info          |
| `create_local_tournament/`            | POST   | Creates a new local tournament.                                                           | JSON payload containing tournament settings (e.g., size, mode) |
| `getCurrentTournamentInformation/`    | GET    | Provides detailed information about the current tournament (e.g., participants, bracket). | _None_                                                         |
| `try_join_random_tournament/`         | POST   | Attempts to join a random tournament.                                                     | JSON payload with user ID and possibly preferences             |
| `try_join_tournament_with_room_code/` | POST   | Allows a user to join a tournament using a room code.                                     | JSON payload with the room code and user identifier            |

---

## User Service API

Base URL: `/api/user-service/`

| Endpoint                      | Method | Description                                                     | Parameters / Body                                                        |
| ----------------------------- | ------ | --------------------------------------------------------------- | ------------------------------------------------------------------------ |
| `register/`                   | POST   | Registers a new user.                                           | JSON payload with registration details (username, email, password, etc.) |
| `generate-qr/<str:username>/` | ANY    | Generates a QR code for the specified user.                     | Username is provided as a URL parameter                                  |
| `update/`                     | POST   | Updates user information.                                       | JSON payload with updated user data                                      |
| `delete/`                     | DELETE | Deletes a user account.                                         | JSON payload with user identifier                                        |
| `profile/`                    | GET    | Retrieves public profile information.                           | _None_                                                                   |
| `getUsername/`                | POST   | Retrieves the username for the current session.                 | _None_                                                                   |
| `info-getter/`                | GET    | Retrieves additional information related to the user.           | _None_                                                                   |
| `get-relationship-status/`    | POST   | Checks the relationship status (friends/blocked) between users. | Query parameters may include user identifiers                            |
| `get_game_history/`           | GET    | Retrieves a user's game history.                                | _None_ or query parameters for pagination                                |
| `get_profile/`                | GET    | Retrieves detailed profile information for a user.              | _None_                                                                   |
| `upload_profile_picture/`     | POST   | Uploads or updates the user's profile picture.                  | Multipart form-data with image file                                      |
| `get_friends/`                | GET    | Retrieves the list of friends for the user.                     | _None_                                                                   |
| `get_user_id/<str:username>/` | GET    | Returns the user ID for the specified username.                 | Username as a URL parameter                                              |
| `search_pilots/`              | GET    | Searches for users (pilots) based on query criteria.            | Query parameters (e.g., search keyword)                                  |
| `leaderboard/`                | GET    | Retrieves the leaderboard information.                          | _None_                                                                   |
| `storage/push/`               | POST   | Pushes data to the user's info storage.                         | JSON payload with the data to be stored                                  |
| `storage/get/`                | GET    | Retrieves data from the user's info storage.                    | _None_                                                                   |
| `storage/delete/`             | DELETE | Deletes specific data from the user's info storage.             | JSON payload or query parameter specifying what to delete                |
| `check_oauth_id/`             | GET    | Checks if a given OAuth ID is already associated with a user.   | Query parameter with OAuth ID                                            |

---

## Auth Service API

Base URL: `/api/auth-service/`

| Endpoint                   | Method | Description                                                              | Parameters / Body                                           |
| -------------------------- | ------ | ------------------------------------------------------------------------ | ----------------------------------------------------------- |
| `logindb/`                 | POST   | Authenticates a user using the local database (username/password login). | JSON payload with login credentials (username and password) |
| `check-auth/`              | GET    | Verifies the current authentication status.                              | _None_                                                      |
| `logout/`                  | POST   | Logs the user out of the system.                                         | _None_ or JSON payload with optional session info           |
| `verify-2fa/`              | POST   | Verifies the 2FA token provided by the user.                             | JSON payload with user identifier and 2FA code              |
| `get_user_id_from_cookie/` | GET    | Retrieves the user ID based on authentication cookies.                   | _None_ (authentication via cookies)                         |
| `oauth/callback/`          | GET    | Callback endpoint for OAuth authentication.                              | Query parameters provided by the OAuth provider             |
| `get-42-url/`              | GET    | Returns the URL for initiating 42 OAuth authentication.                  | _None_                                                      |
| `request-password-reset/`  | POST   | Initiates the password reset process for a user.                         | JSON payload with the user's email or username              |
| `verify-reset-code/`       | POST   | Verifies the password reset code sent to the user.                       | JSON payload with reset code and user identifier            |
| `change-password/`         | POST   | Changes the user's password after a successful reset code verification.  | JSON payload with new password and user identifier          |

---

## Authentication Details

-   **JWT Protection:**  
    Most API requests must include a valid JWT in the header. For example:

```javascript
const response = await fetch('/api/auth-service/check-auth/', {
	method: 'GET',
	credentials: 'include',
});
```

-   **Token Issuance:**  
    Tokens are issued upon successful login (e.g., via the `logindb/` endpoint) and should be stored securely on the client side.

-   **Token Expiry:**  
    If a token is expired or invalid, endpoints will return an HTTP 401 Unauthorized response.

---

## Error Handling

For most endpoints:

-   **Missing/Invalid JWT:**  
    Returns `HTTP 401 Unauthorized` with a message indicating that the token is missing or invalid.
-   **Validation Errors:**  
    Returns `HTTP 400 Bad Request` with details about the invalid or missing parameters.
-   **Server Errors:**  
    Returns `HTTP 500 Internal Server Error` if an unexpected condition occurs.

Sample error response:

```json
{
	"error": "Unauthorized: Invalid token."
}
```
