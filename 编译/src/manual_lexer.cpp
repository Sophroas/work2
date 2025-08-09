#include "manual_lexer.h"
#include <unordered_map>
#include <cctype>

ManualLexer::ManualLexer(const std::string& source) 
    : input(source), position(0), line(1), column(1) {}

char ManualLexer::current_char() {
    if (position >= input.length()) {
        return '\0';
    }
    return input[position];
}

char ManualLexer::peek_char(size_t offset) {
    size_t peek_pos = position + offset;
    if (peek_pos >= input.length()) {
        return '\0';
    }
    return input[peek_pos];
}

void ManualLexer::advance() {
    if (position < input.length()) {
        if (current_char() == '\n') {
            line++;
            column = 1;
        } else {
            column++;
        }
        position++;
    }
}

void ManualLexer::skip_whitespace() {
    while (current_char() != '\0' && std::isspace(current_char())) {
        advance();
    }
}

void ManualLexer::skip_comment() {
    if (current_char() == '/' && peek_char() == '/') {
        // 单行注释
        while (current_char() != '\0' && current_char() != '\n') {
            advance();
        }
    } else if (current_char() == '/' && peek_char() == '*') {
        // 多行注释
        advance(); // 跳过 '/'
        advance(); // 跳过 '*'
        
        while (current_char() != '\0') {
            if (current_char() == '*' && peek_char() == '/') {
                advance(); // 跳过 '*'
                advance(); // 跳过 '/'
                break;
            }
            advance();
        }
    }
}

Token ManualLexer::read_number() {
    std::string number;
    int start_line = line;
    int start_column = column;
    
    // 处理负号
    if (current_char() == '-') {
        number += current_char();
        advance();
    }
    
    // 读取数字
    while (current_char() != '\0' && is_digit(current_char())) {
        number += current_char();
        advance();
    }
    
    return Token(TokenType::NUMBER, number, start_line, start_column);
}

Token ManualLexer::read_identifier() {
    std::string identifier;
    int start_line = line;
    int start_column = column;
    
    while (current_char() != '\0' && (is_alnum(current_char()) || current_char() == '_')) {
        identifier += current_char();
        advance();
    }
    
    TokenType type = get_keyword_type(identifier);
    return Token(type, identifier, start_line, start_column);
}

bool ManualLexer::is_alpha(char c) {
    return std::isalpha(c) || c == '_';
}

bool ManualLexer::is_digit(char c) {
    return std::isdigit(c);
}

bool ManualLexer::is_alnum(char c) {
    return std::isalnum(c) || c == '_';
}

TokenType ManualLexer::get_keyword_type(const std::string& word) {
    static const std::unordered_map<std::string, TokenType> keywords = {
        {"int", TokenType::INT},
        {"void", TokenType::VOID},
        {"if", TokenType::IF},
        {"else", TokenType::ELSE},
        {"while", TokenType::WHILE},
        {"break", TokenType::BREAK},
        {"continue", TokenType::CONTINUE},
        {"return", TokenType::RETURN}
    };
    
    auto it = keywords.find(word);
    return (it != keywords.end()) ? it->second : TokenType::IDENTIFIER;
}

Token ManualLexer::next_token() {
    while (current_char() != '\0') {
        skip_whitespace();
        
        if (current_char() == '\0') {
            break;
        }
        
        // 跳过注释
        if (current_char() == '/' && (peek_char() == '/' || peek_char() == '*')) {
            skip_comment();
            continue;
        }
        
        int start_line = line;
        int start_column = column;
        char c = current_char();
        
        // 数字（包括负数）
        if (is_digit(c) || (c == '-' && is_digit(peek_char()))) {
            return read_number();
        }
        
        // 标识符和关键字
        if (is_alpha(c)) {
            return read_identifier();
        }
        
        // 双字符运算符
        if (c == '<' && peek_char() == '=') {
            advance(); advance();
            return Token(TokenType::LE, "<=", start_line, start_column);
        }
        if (c == '>' && peek_char() == '=') {
            advance(); advance();
            return Token(TokenType::GE, ">=", start_line, start_column);
        }
        if (c == '=' && peek_char() == '=') {
            advance(); advance();
            return Token(TokenType::EQ, "==", start_line, start_column);
        }
        if (c == '!' && peek_char() == '=') {
            advance(); advance();
            return Token(TokenType::NE, "!=", start_line, start_column);
        }
        if (c == '&' && peek_char() == '&') {
            advance(); advance();
            return Token(TokenType::AND, "&&", start_line, start_column);
        }
        if (c == '|' && peek_char() == '|') {
            advance(); advance();
            return Token(TokenType::OR, "||", start_line, start_column);
        }
        
        // 单字符运算符和分隔符
        advance();
        switch (c) {
            case '+': return Token(TokenType::PLUS, "+", start_line, start_column);
            case '-': return Token(TokenType::MINUS, "-", start_line, start_column);
            case '*': return Token(TokenType::MULTIPLY, "*", start_line, start_column);
            case '/': return Token(TokenType::DIVIDE, "/", start_line, start_column);
            case '%': return Token(TokenType::MODULO, "%", start_line, start_column);
            case '<': return Token(TokenType::LT, "<", start_line, start_column);
            case '>': return Token(TokenType::GT, ">", start_line, start_column);
            case '!': return Token(TokenType::NOT, "!", start_line, start_column);
            case '=': return Token(TokenType::ASSIGN, "=", start_line, start_column);
            case '(': return Token(TokenType::LPAREN, "(", start_line, start_column);
            case ')': return Token(TokenType::RPAREN, ")", start_line, start_column);
            case '{': return Token(TokenType::LBRACE, "{", start_line, start_column);
            case '}': return Token(TokenType::RBRACE, "}", start_line, start_column);
            case ';': return Token(TokenType::SEMICOLON, ";", start_line, start_column);
            case ',': return Token(TokenType::COMMA, ",", start_line, start_column);
            default:
                return Token(TokenType::ERROR_TOKEN, std::string(1, c), start_line, start_column);
        }
    }
    
    return Token(TokenType::EOF_TOKEN, "", line, column);
}

std::vector<Token> ManualLexer::tokenize() {
    std::vector<Token> tokens;
    Token token = next_token();
    
    while (token.type != TokenType::EOF_TOKEN) {
        tokens.push_back(token);
        token = next_token();
    }
    
    tokens.push_back(token); // 添加EOF token
    return tokens;
}

std::string ManualLexer::token_type_to_string(TokenType type) {
    switch (type) {
        case TokenType::NUMBER: return "NUMBER";
        case TokenType::IDENTIFIER: return "IDENTIFIER";
        case TokenType::INT: return "INT";
        case TokenType::VOID: return "VOID";
        case TokenType::IF: return "IF";
        case TokenType::ELSE: return "ELSE";
        case TokenType::WHILE: return "WHILE";
        case TokenType::BREAK: return "BREAK";
        case TokenType::CONTINUE: return "CONTINUE";
        case TokenType::RETURN: return "RETURN";
        case TokenType::PLUS: return "PLUS";
        case TokenType::MINUS: return "MINUS";
        case TokenType::MULTIPLY: return "MULTIPLY";
        case TokenType::DIVIDE: return "DIVIDE";
        case TokenType::MODULO: return "MODULO";
        case TokenType::LT: return "LT";
        case TokenType::GT: return "GT";
        case TokenType::LE: return "LE";
        case TokenType::GE: return "GE";
        case TokenType::EQ: return "EQ";
        case TokenType::NE: return "NE";
        case TokenType::AND: return "AND";
        case TokenType::OR: return "OR";
        case TokenType::NOT: return "NOT";
        case TokenType::ASSIGN: return "ASSIGN";
        case TokenType::LPAREN: return "LPAREN";
        case TokenType::RPAREN: return "RPAREN";
        case TokenType::LBRACE: return "LBRACE";
        case TokenType::RBRACE: return "RBRACE";
        case TokenType::SEMICOLON: return "SEMICOLON";
        case TokenType::COMMA: return "COMMA";
        case TokenType::EOF_TOKEN: return "EOF";
        case TokenType::ERROR_TOKEN: return "ERROR";
        default: return "UNKNOWN";
    }
}
